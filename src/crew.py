from crewai import Agent, Crew, Process, Task
from langchain_community.utilities.sql_database import SQLDatabase
from langchain_core.prompts import ChatPromptTemplate

from logger import LLMCallbackHandler
from crewai import LLM
from pathlib import Path
from crewai.tools import tool
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_community.tools.sql_database.tool import (
    InfoSQLDatabaseTool,
    ListSQLDatabaseTool,
    QuerySQLCheckerTool,
    QuerySQLDataBaseTool,
)
from textwrap import dedent
import streamlit as st

if 'db' not in st.session_state:
    st.session_state['db'] = SQLDatabase.from_uri('mysql+pymysql://root:123456789@34.68.157.83:3306/e-commerce')
db = st.session_state['db']

llm = LLM(
    model="gemini/gemini-1.5-pro-latest",
	temperature=0.0,
	callbacks=[LLMCallbackHandler(Path("prompts.jsonl"))],
)

llm_langchain = ChatGoogleGenerativeAI(
	model="gemini-1.5-pro",
	temperature=0.0,
	callbacks=[LLMCallbackHandler(Path("prompts.jsonl"))],
)

def streamlit_callback(step_output):
    st.markdown(step_output)

@tool("list_tables")
def list_tables() -> str:
    """List the available tables in the database"""
    return ListSQLDatabaseTool(db=db).invoke("")

@tool("tables_schema")
def tables_schema(tables: str) -> str:
    """
    Input is a comma-separated list of tables, output is the schema and sample rows
    for those tables. Be sure that the tables actually exist by calling `list_tables` first!
    Example Input: table1, table2, table3
    """
    tool1 = InfoSQLDatabaseTool(db=db)
    return tool1.invoke(tables)

@tool("execute_sql")
def execute_sql(sql_query: str) -> str:
    """
    Execute a SQL query against the database. Returns the result. If the query is not correct, an error message will be returned.
    If an error is returned, rewrite the query, check the query, and try again.
    If you encounter an issue with Unknown column 'xxxx' in 'field list', use tables_schema to query the correct table fields.
    """
    return QuerySQLDataBaseTool(db=db).invoke(sql_query)

@tool("check_sql")
def check_sql(sql_query: str) -> str:
    """
    Use this tool to double check if your query is correct before executing it. Always use this
    tool before executing a query with `execute_sql`.
    """
    res = QuerySQLCheckerTool(db=db, llm=llm_langchain).invoke({"query": sql_query})
    st.session_state['sql_query'] = res
    print("-----***---")
    print(res)
    return res

recommendation = Agent(
	role="Recommendation",
	goal="To provide suggestions to users regarding the queries they can ask",
	backstory=dedent(
		"""
		You understand user query and then provide more meaningful suggestions to the user
		so as to help him to getter better insights from the system by asking the right queries.
		Suggest only as per the schema and that too for tables related to the original query.
		Use the `list_tables` to find available tables.
		Use the `tables_schema` to understand the metadata for the tables.
		"""
	),
	llm=llm,
	allow_delegation=False,
	step_callback=streamlit_callback,
	tools=[list_tables, tables_schema],
	verbose=True,
)

sql_dev = Agent(
	role="Senior Database Engineer",
	goal="Construct and execute SQL queries based on a request",
	backstory=dedent(
		"""
		You are an experienced database engineer who is master at creating efficient and complex SQL queries.
		You have a deep understanding of how different databases work and how to optimize queries. You should only
		generate select queries. Never generate any DDL or DML queries. 
		Use the `list_tables` to find available tables.
		Use the `tables_schema` to understand the metadata for the tables.
		Use the `check_sql` to check your queries for correctness.
		Use the `execute_sql` to execute queries against the database.
		"""
	),
	llm=llm,
	tools=[list_tables, tables_schema, execute_sql, check_sql],
	memory=False,
	allow_delegation=False,
	step_callback=streamlit_callback,
	verbose=True,
)

data_formatter= Agent(
	role="Data Formatter",
	goal="You transform the output of the sql query to a more human readable format. ",
	backstory=dedent(
		"""
		Your primary task is to convert the SQL query output to more human readable format.
		You have the original user query along with the data fetched from a relational database for that query. 
		Data is 100% correct and represents what the query asked for.
		We aim to provide natural language output to user query. If possible answer the query in one line but if
		there are more records that we can have a bulleted list or a table.
		"""
	),
	llm=llm,
	allow_delegation=False,
	step_callback=streamlit_callback,
	verbose=True,
)

extract_data = Task(
	description="Extract data that is required for the query `{query}`",
	expected_output="Database results along with the headers",
	agent=sql_dev,
)

format_data = Task(
	description="Format the data as received form the database to provide a helpful response for the query `{query}`",
	expected_output="Summarized answer to the original query in markdown format.",
	agent=data_formatter,
	context=[extract_data],
)

recommendation_task = Task(
	description="Provide suggestion as per user query `{query}`",
	expected_output="4 different suggestions",
	agent=recommendation,
)


crew = Crew(
    agents=[sql_dev, data_formatter],
    tasks=[extract_data, format_data],
    process=Process.sequential,
    verbose=True,
    memory=False,
    output_log_file="crew.log",
)

crew_recommendation = Crew(
    agents=[recommendation],
    tasks=[recommendation_task],
    process=Process.sequential,
    verbose=True,
    memory=False,
    output_log_file="crew.log",
)

def get_suggestions(query):
    messages = [
		(
			"system", "This is a text to sql system. It converts natural language queries into SQL queries. You are a helpful assistant that provides suggestions to users regarding the queries they can ask to system",
		),
		("human", f"Please provide 4 suggestions similar to the query `{query}`. Just provide the 4 suggestions without any extra stuff."),
	]
    ai_msg = llm_langchain.invoke(messages)
    return ai_msg


# inputs = {
# 	"query": "What is the average order value."
# }
#
# result = crew.kickoff(inputs=inputs)
# print(result)
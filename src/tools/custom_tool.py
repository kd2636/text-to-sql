from crewai.tools import BaseTool
from typing import Type

from langchain_community.utilities import GoogleSerperAPIWrapper
from pydantic import BaseModel, Field
from langchain_community.utilities.sql_database import SQLDatabase
from langchain_community.tools.sql_database.tool import (
    ListSQLDatabaseTool,
)

db = SQLDatabase.from_uri('mysql+pymysql://root:123456789@34.68.157.83:3306/e-commerce')

class ListTables(BaseTool):
    name: str = "ListTables"
    description: str = "List the available tables in the database"
    search: GoogleSerperAPIWrapper = Field(default_factory=GoogleSerperAPIWrapper)

    def _run(self, query: str) -> str:
        """Returns tables present in the database"""
        try:
            return ListSQLDatabaseTool(db=db).invoke("")
        except Exception as e:
            return f"Error performing search: {str(e)}"
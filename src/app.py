import streamlit as st
from crew import crew, get_suggestions
from crew import crew_recommendation
import threading

from src.text_to_sql.crew import recommendation

#
# def task1(input_data, output_list):
#     result = crew.kickoff(inputs=input_data)
#     output_list.append(result)
#
# # Define a function for the second thread
# def task2(input_data, output_list):
#     result = crew_recommendation.kickoff(inputs=input_data)
#     output_list.append(result)


def main():


    st.title("Text To SQL !!")


    user_input = st.text_area("User query: ", "")

    if st.button("Submit"):
        if user_input:
            inputs = {
                "query": f"""{user_input}"""
            }
            st.session_state['sql_query'] = None
            with st.status("🤖 **Agents at work...**", state="running", expanded=True) as status:
                with st.container(height=500, border=False):
                    # result_output = []
                    # recommendations_output = []
                    result = crew.kickoff(inputs=inputs)
                    recommendations = get_suggestions(user_input)
                    # recommendations = crew_recommendation.kickoff(inputs=inputs)
                    # thread1 = threading.Thread(target=task1, args=(inputs, result_output))
                    # thread2 = threading.Thread(target=task2, args=(inputs, recommendations_output))
                    # thread1.start()
                    # thread2.start()
                    # thread1.join()
                    # thread2.join()
                status.update(label="✅ Results are ready!",
                              state="complete", expanded=False)

            st.subheader("Here are your results", anchor=False, divider="rainbow")
            st.markdown(result)
            st.subheader("Here is the sql query used to get this", anchor=False, divider="rainbow")
            sql_query = st.session_state['sql_query']
            st.markdown(sql_query)
            st.subheader("Can try these as well", anchor=False, divider="rainbow")
            st.markdown(recommendations.content)


if __name__ == "__main__":
    main()
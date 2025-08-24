import streamlit as st
from crew import crew

def main():


    st.title("Text To SQL !!")


    if "messages" not in st.session_state:
        st.session_state.messages = []

    for message in st.session_state.messages:
        with st.chat_message(message['role']):
            st.markdown(message['content'])

    if prompt := st.chat_input(""):
        with st.chat_message('user'):
            st.markdown(prompt)
        st.session_state.messages.append({"role": "user", "content": prompt})

        inputs = {
            "query": f"""{prompt}"""
        }

        result = crew.kickoff(inputs=inputs)
        with st.chat_message('assistant'):
            st.markdown(result.raw)
        st.session_state.messages.append({"role": "assistant", "content": result.raw})


    # user_input = st.text_area("User query: ", "")
    #
    # if st.button("Submit"):
    #     if user_input:
    #         inputs = {
    #             "query": f"""{user_input}"""
    #         }
    #
    #         result = crew.kickoff(inputs=inputs)
    #         st.write(result.raw)

if __name__ == "__main__":
    main()
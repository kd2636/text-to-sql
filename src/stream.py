# import re
# import streamlit as st
#
#
# ###########################################################################################
# # Print agent process to Streamlit app container                                          #
# # This portion of the code is adapted from @AbubakrChan; thank you!                       #
# # https://github.com/AbubakrChan/crewai-UI-business-product-launch/blob/main/main.py#L210 #
# ###########################################################################################
# class StreamToExpander:
#     def __init__(self, expander):
#         self.expander = expander
#         self.buffer = []
#         self.colors = ['red', 'green', 'blue', 'orange']  # Define a list of colors
#         self.color_index = 0  # Initialize color index
#
#     def write(self, data):
#         # Filter out ANSI escape codes using a regular expression
#         cleaned_data = re.sub(r'\x1B\[[0-9;]*[mK]', '', data)
#
#         # Check if the data contains 'task' information
#         task_match_object = re.search(r'\"task\"\s*:\s*\"(.*?)\"', cleaned_data, re.IGNORECASE)
#         task_match_input = re.search(r'task\s*:\s*([^\n]*)', cleaned_data, re.IGNORECASE)
#         task_value = None
#         if task_match_object:
#             task_value = task_match_object.group(1)
#         elif task_match_input:
#             task_value = task_match_input.group(1).strip()
#
#         if task_value:
#             st.toast(":robot_face: " + task_value)
#
#         # Check if the text contains the specified phrase and apply color
#         if "Entering new CrewAgentExecutor chain" in cleaned_data:
#             # Apply different color and switch color index
#             self.color_index = (self.color_index + 1) % len(self.colors)  # Increment color index and wrap around if necessary
#
#             cleaned_data = cleaned_data.replace("Entering new CrewAgentExecutor chain", f":{self.colors[self.color_index]}[Entering new CrewAgentExecutor chain]")
#
#         if "Senior Database Engineer" in cleaned_data:
#             # Apply different color
#             cleaned_data = cleaned_data.replace("Senior Database Engineer", f":{self.colors[self.color_index]}[Senior Database Engineer]")
#         if "Senior Data Analyst" in cleaned_data:
#             cleaned_data = cleaned_data.replace("Senior Data Analyst", f":{self.colors[self.color_index]}[Senior Data Analyst]")
#         if "Finished chain." in cleaned_data:
#             cleaned_data = cleaned_data.replace("Finished chain.", f":{self.colors[self.color_index]}[Finished chain.]")
#
#         self.buffer.append(cleaned_data)
#         if "\n" in data:
#             self.expander.write(''.join(self.buffer), unsafe_allow_html=True)
#             self.buffer = []
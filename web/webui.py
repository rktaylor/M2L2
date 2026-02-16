import gradio as gr
import os

def hello_world():
    env_variable_test = os.getenv("GRADIOVAR", "...world!")
    return "Hello {}".format(env_variable_test)

demo = gr.Interface(
    fn=hello_world,
    inputs=[],
    outputs=["text"],
    api_name="ping_env"
)

# launches the app
if __name__ == "__main__":
    demo.launch()
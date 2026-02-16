import gradio as gr
import os

# TODO, multiple pages

def hello_world():
    """
    This is a simple method to demonstrate the gradio frontend.
    It reads an environment variable `GRADIOVAR` and appends that
    to a welcome message. Finding none, it says `...world!`
    """
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
    print("Server up at localhost:7860")
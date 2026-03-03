####################################################
#
# This project depends on gradio.app for the web UI.
# Read about it here:
# https://www.gradio.app/guides/quickstart
#
####################################################

import gradio as gr
import os
from ..medlands import GrassController

# TODO, multiple pages

def hello_world():
    """
    This is a simple method to demonstrate the gradio frontend.
    It reads an environment variable `GRADIOVAR` and appends that
    to a welcome message. Finding none, it says `...world!`
    """
    env_variable_test = os.getenv("GRADIOVAR", "...world!")
    return "Hello {}".format(env_variable_test)

def run_grass(command, input_flags):
    grass = GrassController.default()
    client = grass.grass_client
    return client.read_command(command, flags=input_flags)

demo2 = gr.Interface(
    fn=run_grass,
    inputs=["text", "text"],
    outputs=["text"],
    api_name="grass.run"
)

demo = gr.Interface(
    fn=hello_world,
    inputs=[],
    outputs=["text"],
    api_name="ping_env"
)

# launches the app
if __name__ == "__main__":
    demo2.launch()
    print("Server up at localhost:7860")
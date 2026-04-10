####################################################
#
# This project depends on gradio.app for the web UI.
# Read about it here:
# https://www.gradio.app/guides/quickstart
#
####################################################

import gradio as gr
import os
import json
import re
from ..grass_helpers import GrassController
from ..iamatest import main 

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

# loading config values
def create_component(key, field):
    """Create Gradio input component based on type and metadata."""
    field_type = field.get("type", "string")
    default = field.get("answer")
    description = field.get("description", "")

    if field_type == "integer":
        return gr.Number(label=key, value=default, precision=0, info=description)
    elif field_type == "double":
        return gr.Number(label=key, value=default, precision=3, info=description)
    elif field_type == "string":
        return gr.Textbox(label=key, value=default, info=description)
    elif isinstance(default, list):  # e.g., "3,2" parsed as list
        return gr.Textbox(label=key, value=",".join(map(str, default)), info=description)
    else:
        return gr.Textbox(label=key, value=default, info=description)

def load_config_and_build_ui(config_path="output_config.json"):
    with open(config_path, "r") as f:
        config = json.load(f)

    with gr.Blocks() as demo:
        gr.Markdown("## Configuration Editor")
        state = gr.State(config)
        for section_name, options in config.items():
            with gr.Accordion(section_name, open=False):
                for opt in options:
                    comp = create_component(opt["key"], opt)
                    # Store updated values back into JSON structure
                    comp.change(
                        fn=lambda val, key=opt["key"], sec=section_name: update_config(state, sec, key, val),
                        inputs=[comp],
                        outputs=[]
                    )
        run_btn = gr.Button("Run", variant="primary")
        output = gr.Textbox(label="Status")
        run_btn.click(fn=run_config, inputs=state, outputs=output)
        return demo

def run_config(state):
    return "Test"

def update_config(state, section, key, value):
    # Update the internal state (can be extended to save to file)
    config = state["value"]
    for opt in config[section]:
        if opt["key"] == key:
            opt["answer"] = value
    return config

# Build and launch
try:
    demo_opts = load_config_and_build_ui("/app/medlands/scratch/options.json")
except:
    demo_opts = load_config_and_build_ui("/home/moss/dev/Medlands/M2L2/medlands/scratch/options.json")
#demo.launch()

with gr.Blocks(title="Medlands Control Plane") as app:
    
    # home page
    with gr.Row():
        gr.Markdown("Landing page")

    # TODO: This should configure the experiment...
    with gr.Row():
        output=gr.Textbook(label="Grass Test Output")
        test_btn = gr.Button("Test Grass")
        test_btn.click(
            fn=run_grass,
            inputs=["text", "text"],
            outputs=["text"]
        )

    with app.route("Configure", "/config"):
        gr.Markdown("# Configuration")
        try:
            config_demo = load_config_and_build_ui("/app/medlands/scratch/options.json")
            config_demo.render()
        except:
            fallback = load_config_and_build_ui("/home/moss/dev/Medlands/M2L2/medlands/scratch/options.json")
            fallback.render()

# launches the app
if __name__ == "__main__":
    #demo2.launch()
    app.launch()
    print("Server up at localhost:7860")
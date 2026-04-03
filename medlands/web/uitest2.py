import gradio as gr
import os
import json
import re
from ..grass_helpers import GrassController

def create_component(key, field):
    """Create Gradio input component based on field type and metadata."""
    field_type = field.get("type", "string")
    default = field.get("answer")
    description = field.get("description", "")
    options = field.get("options")  # For dropdown choices

    if options:
        return gr.Dropdown(
            choices=options,
            value=default,
            label=key,
            info=description
        )
    elif field_type == "integer":
        return gr.Number(label=key, value=default, precision=0, info=description)
    elif field_type == "double":
        return gr.Number(label=key, value=default, precision=3, info=description)
    elif field_type == "string":
        return gr.Textbox(label=key, value=default, info=description)
    else:
        return gr.Textbox(label=key, value=default, info=description)

def update_config(state, section, key, value):
    config = state["value"]
    config[section][key]["answer"] = value
    return config

def load_config_and_build_ui(config_path="options.json"):
    if not os.path.exists(config_path):
        raise FileNotFoundError(f"Config file not found: {config_path}")

    with open(config_path, "r") as f:
        config = json.load(f)

    with gr.Blocks() as demo:
        gr.Markdown("## Configuration Editor")
        state = gr.State(config)

        for section_name, options in config.items():
            if not isinstance(options, dict):
                continue

            with gr.Accordion(section_name, open=False):
                for key, field in options.items():
                    # Skip internal metadata like GIS_FLAGS
                    if key == "GIS_FLAGS":
                        continue

                    comp = create_component(key, field)
                    comp.change(
                        fn=lambda val, sec=section_name, k=key: update_config(state, sec, k, val),
                        inputs=[comp],
                        outputs=[]
                    )
        return demo

# Load UI with fallback paths
try:
    demo_opts = load_config_and_build_ui("/app/medlands/scratch/options.json")
except FileNotFoundError:
    demo_opts = load_config_and_build_ui("/home/moss/dev/Medlands/M2L2/medlands/scratch/options.json")

if __name__ == "__main__":
    demo_opts.launch()
    print("Server up at localhost:7860")   
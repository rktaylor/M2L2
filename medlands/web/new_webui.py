import gradio as gr
import os
import json
import re
from ..grass_helpers import GrassController
from ..soildepth_test import SoilDepth

def run_grass(command, input_flags):
    grass = GrassController.default()
    client = grass.grass_client
    return client.read_command(command, flags=input_flags)

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
        run_btn = gr.Button("Run", variant="primary")
        output = gr.Textbox(label="Status")
        run_btn.click(fn=run_config, inputs=state, outputs=output)
        return demo

def run_config(state):
    sim = SoilDepth(state)
    answer = sim.test_me()
    return answer


with gr.Blocks(title="Medlands Control Plane") as app:
    
    # home page
    with gr.Row():
        gr.Markdown("Landing page")

    # TODO: This should configure the experiment...
    with gr.Row():
        cmd_input = gr.Textbox(label="Command")
        flag_input = gr.Textbox(label="Flags")
        output = gr.Textbox(label="Output")
        test_btn = gr.Button("Test Grass")
        test_btn.click(
            fn=run_grass,
            inputs=[cmd_input, flag_input],
            outputs=output
        )

with app.route("ConfigureSoilDepth", "/setupSoilDepth"):
    gr.Markdown("# Configuration for Soil Depth")
    try:
        config_page = load_config_and_build_ui("/app/medlands/scratch/options.json")
    except:
        config_page = load_config_and_build_ui("/home/moss/dev/Medlands/M2L2/medlands/scratch/options.json")
    config_page.render()

# launches the app
if __name__ == "__main__":
    #demo2.launch()
    app.launch()
    print("Server up at localhost:7860")
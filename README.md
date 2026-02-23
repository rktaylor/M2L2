# What is Medlands?
The Medlands Laboratory is an ensemble of disparate model-parts for understanding how landscapes evolve through feedback loops with human occupation/land-use. It was originally written in a mixture of Java and Python, with heavy dependences on GRASS. Medlands Lite was a fork of this project that rewrote the ABM in Python and modernized some dependencies.

This repository is a fork of the Medlands Lite codebase. Our objectives are:
1. Ensure dependency closure 
2. Improve onboarding time
3. Prepare the codebase for new development

To that end, this fork largely consists of containerization and UI improvements, and it is our intention to make pull requests into that repository once those goals are functionally complete.

## Learn More about Medlands...
- [Upstream MML-Lite Repository](https://github.com/comses/MML-Lite) of which this is a fork.
- [Original Medlands V1 (with Java)](https://github.com/comses/MMLv1), also found on the [COMSES Website](https://www.comses.net/codebases/4609/releases/1.1.0/). 
- To read more about the Socio-Ecological Systems Science behind MedLands, ["Experimental Socioecology..." by Barton et al.](http://www.sciencedirect.com/science/article/pii/S2213305415300278) is a fantastic place to start.

Legacy documentation can be found in [OLD_README.md](LEGACY/OLD_README.md). 

# Where To Begin:
First of all, pardon the mess. The intention is that this document will be sanitized and replace the old version entirely.

To begin with M2L2, you need to install Podman and Distrobox.

## Installing Podman:
On Ubuntu:
> sudo apt install podman

On MacOS: defer to the official documentation [here](https://podman-desktop.io/docs/installation/macos-install)

## Installing Distrobox
On Ubuntu:
> sudo apt install distrobox

On MacOS:
This is technically not supported, and made possible only through community effort. Proceed with caution.

>podman machine init
>podman machine start

This will prepare podman as a runtime.

The installer script `mac_install.sh` was pulled [from this github with no license file](https://gist.github.com/gianlucamazza/f9b57d6796a97981908f7c2bbda706fc) as a safety measure. The code within has been read by a human and probably isn't malware.

(To be certain something isn't malware, read it yourself.)
(Even then, there's always something in the stack we're putting inside our trust boundary for our threat models. Unless we build the computer ourself from scratch, we can never be completely certain.)

To run it:
> bash mac_installer.sh

To test your distrobox:
> distrobox create --name test --image ubuntu:latest
This will pull the latest container image of ubuntu, which is generally a safe thing to do, as it is an extremely popular, well-maintained Linux distribution (distro!)

> distrobox enter test
> uname -a

This should say "Linux" followed by a bunch of system/user specific information. If you get this far, you're good to go. Now run

> exit

To return to your normal shell.

### Additional Mac Requirements
For GUIs, you'll need to install and configure xquartz for X11 forwarding.

> brew install --cask xquartz

(TODO - complete later)

## First Run
Once podman and distrobox are installed,

1. Build the container image:
> podman build -f Dockerfile -t medpod:1

This will trigger a local container image build. (If a version of this container is hosted in a registry, you may pull it instead.)
The `f` flag points podman to the configuration to build, and `t` tells it what to name the resulting container.

The number after the `:` is the tag, and is used to version images. You can vary the name and tag however you please -- they are organizational tools for keeping your workspace ordered.

You will see a lot of output text, and it will take time, even on new systems.

2. Build the distrobox
> distrobox create --name db --image medpod:1 

Like before, `--name` names the *distrobox* runtime, and `--image` specifies what *container image* to build that runtime from. 

### TODO - NOTE
I managed to get the GUI to launch with XQuartz on MacOS but not with Distrobox. Getting Distrobox to build it, and then using 
> podman exec -it ${RUNNING_CONTAINER_NAME} /bin/bash
I then called Grass and invoked the Gui and it worked.

3. Launch program
> distrobox enter db

This step requires the name of the distrobox runtime, NOT the container image. This will appear to do nothing, loading a new prompt for your shell. The advantage of distrobox is that it makes containers run in such a way that they *appear* to be native apps.

To make sure you're actually "in" the container:

> ls /app/

This should show a folder called `medlands`. If so, you're in the container! (This path won't exist in a shell outside the container, unless you create it, which you shouldn't need to.)

4. Use Conda to Launch
Python dependencies and Grass are managed through Conda. To launch,

> bash
> conda activate runtime

This should change your prompt to say `(runtime)` at the beginning. Now you have access to all your required dependencies, and can begin work.

# Contributing
Please read the following before checking in new code.

## Running Tests
To run unit tests, 
1. Ensure you're in the root directory of the repository
2. Specify the full path of the tests to run. If testing the web components:
> python -m unittest -v web.test.hwt_web


# Platform Specific Installation Instructions

Apple Arm64: just link to an Amazon page selling a different mac.
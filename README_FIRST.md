# What is Medlands?
The Medlands Laboratory is an ensemble of disparate model-parts for understanding how landscapes evolve through feedback loops with human occupation/land-use. It was originally written in a mixture of Java and Python, with heavy dependences on GRASS. Medlands Lite was a fork of this project that rewrote the ABM in Python and modernized some dependencies.

# What is M2L2? 
A fork of a fork, the purpose of which is to (a) ensure dependency closure, (b) improve onboarding time, and (c) prepare the model for future extensions. It does so with containers.

# Where To Begin:
First of all, pardon the mess. The intention is that this document will be sanitized and replace the existing README.md file. 

To begin with M2L2, you need to install Podman and Distrobox.

## Installing Podman:
On Ubuntu:
> sudo apt install podman

On MacOS: defer to the official documentation [here](https://podman-desktop.io/docs/installation/macos-install)

## Installing Distrobox
On Ubuntu:
> sudo apt install distrobox

On MacOS: TODO
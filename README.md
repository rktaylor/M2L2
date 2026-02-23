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

# Table of Contents
1. [Installation](#installation)
2. [User Guide](#user-guide)
3. [Contributing](#contributing)




# Installation

First, clone the repository onto your development machine.

## Platform-specific Steps

Medlands is officially supported for Unix systems on Amd64-x86 chips (Intel, AMD). Support for Apple Silicon is still in development.

You will need to install `podman`, a `docker` alternative. `docker` should also work, but is not officially supported. ([Why podman?](#podman-vs-docker))

### Linux-x86

For Debian-based (Debian, Ubuntu, Mint, Pop_OS, etc.) :

> sudo apt install podman

### MacOS-x86

Ensure you have [homebrew installed](https://brew.sh/).

> brew install podman

### MacOS-arm64 (M1 and Later)

[Buy something better](https://www.lenovo.com/us/en/p/laptops/thinkpad/thinkpadp/thinkpad-p14s-gen-6-14-inch-amd-mobile-workstation/21qlcto1wwus2).

(NB: the above is humorous and will be replaced with official guidance once a solution is found. The author does recommend that model of computer, however.)

## Initialize Podman

The following is platform-independent:

> podman machine init

This downloads required virtualization software and configures the container host.

> podman machine start

At this point, you should be good to go. Optionally, you may test:

> podman run --rm hello-world

This is a lightweight image meant to test that Podman is operating correctly. If it works, it should output this ascii art:

```
!... Hello Podman World ...!

         .--"--.           
       / -     - \         
      / (O)   (O) \        
   ~~~| -=(,Y,)=- |         
    .---. /`  \   |~~      
 ~/  o  o \~~~~.----. ~~   
  | =(X)= |~  / (O (O) \   
   ~~~~~~~  ~| =(Y_)=-  |   
  ~~~~    ~~~|   U      |~~ 
```

## Native Filesystems and GUI (Optional)

TODO - Revamped instructions for Distrobox.

# User Guide

To get started with Medlands...

## Deploy Container

First, you need to build the container image *here*. From the root directory of this repository:

> podman build --format docker --platform linux/amd64,linux/arm64 --manifest medlands .

(TODO: The above is currently failing for arm64).

Once built, you can either interact with Medlands through the WebUI or the Terminal/Shell.

To *launch* the container (start the program):

## Run Medlands from the CLI

> podman run -it medlands /bin/bash

This will drop you into a running container. You'll notice your username and hostname in your terminal have changed. To leave, `exit`. 

(TODO: we're still standardizing input formats for the legacy code)

### Execute Tests (Optional)

From within the container shell:

> python -m unittest discover

Optionally, you can add `-v`, `-vv`, or `-vvv` for verbose, very verbose, or VERY VERY VERBOSE debugging outputs.

We recommend running tests on initial deployment and after a code-change. Otherwise, you may ignore them.

## Run Medlands from the WebUI

> podman run -d -p 7860:7860 medlands

This will launch the web service, which you can reach [localhost](localhost:7860).

(TODO: update with execution steps once web ui done.)

## Run Medlands from GRASS

(TODO: requires X11 forwarding in the optional Native filesystem step above.)

# Contributing

Contributions are more than welcome! We ask that you try to follow these conventions:

1. Unit Tests for all changes in `web/` are mandatory.
2. Unit Tests should be named with the pattern `TestedFunctionality_Condition_Expectation`. See examples in code.
3. Unit Test logic should be sorted into clearly-labeled `arrange`, `act`, and `assert` steps.
4. All pull requests should include proof of a successful podman build on both Amd64-x86 and Arm64 architectures.
5. Campsite Rule: try to leave things a little better than you found them, but at the very least, pack-in-pack-out. 

For ease of maintainability, we would prefer if code contributions are made only in Python, except where Java is required to interface with GRASS or where C# is required to interface with Landis-II. 

The choice of `gradio.app` for the web UI front-end was intentional: python fluency is much easier to expect of science contributors than javascript/html/css fluency is. 

# Credits

This fork of the MedLands project is being maintained by Sean Bergin and Roy Taylor.

MML-Lite was developed by Isaac Ullah and Michael Barton.

(TODO) Maintainer list for MMLv1 is missing on Github, likely because of how the repository was initialized. A list of contributors can be derived from publications.

# Appendices

## Podman vs Docker

Podman is more secure as it does not require a daemon or root-level access to run. It also seemlessly integrates with Enterprise Linux, making scaled-up deployments effortless.

Podman is also more permissive in its open-source licensing, as the entire stack is licensed under Apache 2.0, whereas only the Docker *Engine* is. Podman is also aligned with the Open Containers Initiative, meaning its *standards* are community-oriented.

(We have made a similar choice in prioritizing "more community, less proprietary" technology in selecting Mamba instead of Conda as the Python Environment Manager.)

They are both containerization architectures, and for most users the difference is semantic. 



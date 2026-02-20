#!/bin/bash

# TODO check if Brew installed, then install it
brew install podman
podman machine init
podman machine start
podman run --rm hello-world
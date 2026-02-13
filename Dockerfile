# syntax=docker/dockerfile:1
FROM registry.fedoraproject.org/fedora:latest

# copy repository, data and dependencies into container
COPY --chmod=777 . /app/medlands/

# install system-level dependencies
RUN dnf -y update && \
    dnf -y install wget && \
    dnf -y install git && \
    dnf clean all

# Install Conda for managing Python and Java dependencies
ENV CONDA_DIR /opt/conda
#RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#    /bin/bash ~/miniconda.sh -b -p /opt/conda

RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# Agree to Conda TOS
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# Run Conda installation
RUN conda env create --file /app/medlands/environment.yml
RUN conda init 

# TODO - this step will always fail for architectural reasons.
#RUN conda activate runtime



# MedLands Setup Steps
# TODO

# TODO update with appropriate entry point. gradio.app entry point?
# CMD ["java", "-jar", "/app/medlands/code/MML/MMLv1.jar"]

FROM docker.io/mambaorg/micromamba:2.5.0

COPY --chmod=777 ./medlands/ /medlands/app
COPY ./data/ /medlands/data
COPY ./web/ /medlands/web
COPY ./LEGACY/run_pen.sh /medlands/run_test.sh

# build python environment
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all --yes

# execute unit tests
CMD ["python", "-m", "unittest", "discover", "-vv"]

# run front end
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"
CMD ["python", "/medlands/web/webui.py"]

# FROM mcr.microsoft.com/devcontainers/miniconda:0-3
# RUN conda install -n base -c conda-forge mamba
# COPY environment.yml ./
# RUN mamba env create -f environment.yml   
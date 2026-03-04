FROM docker.io/mambaorg/micromamba:2.5.0

COPY --chmod=777 ./medlands/ /app/medlands
COPY ./data/ /app/data

# build python environment
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all --yes

WORKDIR /app

# run front end
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"
CMD ["python", "-m", "medlands.web.webui"]
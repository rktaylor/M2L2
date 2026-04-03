FROM docker.io/mambaorg/micromamba:2.5.0

COPY --chmod=777 ./medlands/ /app/medlands
COPY ./data/ /app/data

# build python environment
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all --yes

WORKDIR /app

COPY ./data/testloc/ /opt/conda/grass84/testloc
#RUN chown -R $MAMBA_USER:$MAMBA_USER /opt/conda/grass84/testloc

ENV GISDBASE="/opt/conda/grass84"
ENV LOCATION_NAME="testloc"
ENV MAPSET="PERMANENT"

# run front end
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

#USER $MAMBA_USER
CMD ["python", "-m", "medlands.web.webui"]
# syntax=docker/dockerfile:1
FROM registry.fedoraproject.org/fedora:latest

# copy repository, data and dependencies into container
COPY --chmod=777 . /app/medlands/

# install system-level dependencies
RUN dnf -y update && \
    dnf -y install python3 && \
    dnf install -y java-25-openjdk-devel && \
    dnf clean all

# install GRASS 6.4 and its dependencies
# TODO once determine adequate source for SPECIFIC grass

# MedLands Setup Steps
# TODO

# Verify installed versions
CMD ["sh", "-c", "python3 --version && java --version"]

# TODO don't hard-code a user path
ENV PATH="/home/moss/asu:/usr/bin:$PATH"

# TODO update with appropriate entry point. gradio.app entry point?
# CMD ["java", "-jar", "/app/medlands/code/MML/MMLv1.jar"]

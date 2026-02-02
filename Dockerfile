# syntax=docker/dockerfile:1
FROM registry.fedoraproject.org/fedora:latest
CMD ["echo", "Hello!"]

# copy repository, data and dependencies into container
COPY --chmod=777 medlands/ /app/medlands/
COPY --chmod=777 grass/grass-6.4.6svn-x86_64-pc-linux-gnu-25_08_2018-install.sh /app/grass/grass-6.4.6svn-x86_64-pc-linux-gnu-25_08_2018-install.sh
COPY grass/grass-6.4.6svn-x86_64-pc-linux-gnu-25_08_2018.tar.gz /app/grass/grass-6.4.6svn-x86_64-pc-linux-gnu-25_08_2018.tar.gz

# install system-level dependencies
RUN dnf -y update && \
    dnf -y install python3 && \
    dnf install -y java-25-openjdk-devel && \
    dnf clean all

# install GRASS 6.4 and its dependencies
RUN /app/grass/grass-6.4.6svn-x86_64-pc-linux-gnu-25_08_2018-install.sh /app/grass/grass-6.4.6svn-x86_64-pc-linux-gnu-25_08_2018.tar.gz

# MedLands Setup Steps

CMD ["sh", "-c", "python3 --version && java --version"]

ENV PATH="/home/moss/asu:/usr/bin:$PATH"

CMD ["java", "-jar", "/app/medlands/code/MML/MMLv1.jar"]

FROM ubuntu:bionic

ARG maps_release_tag=latest
ENV MAPS_RELEASE_TAG=$maps_release_tag

USER root

ENV EQEMU_HOME=/home/eqemu
ENV EQEMU_MAPS_DIR=/home/eqemu/maps

ENV DEBIAN_FRONTEND=noninteractive

# Install basic packages
RUN apt-get update -y && \
    apt-get install -y bash curl wget git

# Set eqemu user
RUN groupadd eqemu && \
    useradd -g eqemu -d $EQEMU_HOME eqemu && \
    mkdir -p $EQEMU_HOME && \
    mkdir -p $EQEMU_MAPS_DIR

# Clone quests
RUN git clone https://github.com/Akkadius/EQEmuMaps.git $EQEMU_MAPS_DIR
RUN if [ "$MAPS_RELEASE_TAG" != "latest" ]; then cd $EQEMU_MAPS_DIR; git fetch --all --tags --prune; git checkout tags/$MAPS_RELEASE_TAG; fi;

# Cleanup unneeded packages
RUN apt-get remove -y git wget curl && \
    apt-get autoremove -y && \
    apt-get clean cache

WORKDIR /home/eqemu
USER eqemu

VOLUME /home/eqemu/maps

ENTRYPOINT ["/usr/bin/tail", "-f", "/dev/null"]
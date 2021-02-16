FROM ubuntu:18.04

COPY entrypoint.sh /entrypoint.sh

WORKDIR /tmp
ARG DEBIAN_FRONTEND=noninteractive

# Install SteamCMD and requirements
RUN chmod 755 /entrypoint.sh \
 && echo steam steam/question select "I AGREE" | debconf-set-selections \
 && echo steam steam/license note '' | debconf-set-selections \
 && dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates locales \
    steamcmd locales libsdl2-2.0-0 libsdl2-2.0-0:i386 \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/games/steamcmd /usr/bin/steamcmd \
 && locale-gen en_US.UTF-8 \
 && useradd -m steamuser

# Unicode support
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US:en"

USER steamuser
WORKDIR /home/steamuser

# Downlaod valheim server
RUN mkdir valheim_server \
 && steamcmd +login anonymous +force_install_dir /home/steamuser/valheim_server +app_update 896660 validate +quit

VOLUME ["/home/steamuser/valheim_data"]
EXPOSE 2456-2458

ENTRYPOINT ["/entrypoint.sh"]

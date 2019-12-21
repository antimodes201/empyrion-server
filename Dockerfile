FROM ubuntu:bionic
MAINTAINER antimodes201

ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV TZ "America/New_York"

RUN export DEBIAN_FRONTEND noninteractive && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y net-tools \ 
	tar \
	unzip \
	curl \
	wget \
	tzdata \
	xz-utils \
	gnupg2 \
	software-properties-common \
	xvfb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    curl -s https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    apt-add-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    apt-get install -y wine-staging=4.10~bionic \
	wine-staging-i386=4.10~bionic \
	wine-staging-amd64=4.10~bionic \
	winetricks && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s '/home/steamuser/Steam' /empyrion && \
    useradd -m steamuser && \
	mkdir -p /steamcmd && \
	mkdir -p /home/steamuser/Steam/logs && \
	chown steamuser:steamuser /steamcmd && \
	chown steamuser:steamuser /empyrion/logs 

USER steamuser

RUN cd /steamcmd && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xf steamcmd_linux.tar.gz && \
	rm steamcmd_linux.tar.gz && \
	/steamcmd/steamcmd.sh +quit

# Make a volume
# contains configs and world saves
VOLUME /empyrion

ADD start.sh /
ENTRYPOINT ["/start.sh"]
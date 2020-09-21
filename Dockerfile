FROM ubuntu:focal

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install packages
RUN apt-get update && \
	apt-get install -y gnupg && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C5E6A5ED249AD24C && \
	echo "deb http://ppa.launchpad.net/deluge-team/stable/ubuntu focal main" >> /etc/apt/sources.list.d/deluge.list && \
	echo "deb-src http://ppa.launchpad.net/deluge-team/stable/ubuntu focal main" >> /etc/apt/sources.list.d/deluge.list && \
	apt-get update && \
	apt-get install -y \
	deluged \
	deluge-console \
	deluge-web
RUN rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*


# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads

CMD ["deluged","-d","-c","/config"]
FROM armhfbuild/debian:latest
MAINTAINER WUTTINAN SUT <wuttinan.wch@gmail.com>
RUN apt-get -y update \
	&& apt-get install -y git python-pip \
	&& pip install -U platformio
RUN mkdir -p /root/nodemcu
RUN /bin/bash -c 'echo -e "y\n" | platformio init -d /root/nodemcu --board nodemcuv2'
ADD code/blink.ino /root/nodemcu/src
RUN rm /root/nodemcu/platformio.ini
ADD env/platformio.ini /root/nodemcu
WORKDIR /root/nodemcu
RUN /bin/bash -c 'echo -e "y\n" | platformio run'
CMD platformio run -t upload


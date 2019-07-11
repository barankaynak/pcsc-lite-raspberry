FROM mcr.microsoft.com/dotnet/core/runtime:2.2-stretch-slim-arm32v7 AS base

RUN apt-get update
RUN apt-get -y install git libusb-dev build-essential libsystemd-dev libudev-dev pkg-config

WORKDIR "/opt"

RUN git clone https://salsa.debian.org/debian/pcsc-lite.git
RUN cd pcsc-lite && ./configure && make && make install
RUN apt-get -y remove build-essential pkg-config libusb-dev libsystemd-dev libudev-dev git
RUN rm -rf /opt/pcsc-lite
WORKDIR "/root"

RUN apt-get -y install pcsc-tools pcscd
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/bash"]

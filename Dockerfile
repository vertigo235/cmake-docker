# Container for building and testing cmake-examples with default cmake v3.5.1
FROM ubuntu:16.04
MAINTAINER vertigo235

ENV OS="Linux"
ENV OSTYPE="linux-gnu"
ENV JAVA_TOOL_OPTIONS="-Djava.net.preferIPv4Stack=true"
ENV GPG_TTY=$(tty)
ENV TERM="xterm"

RUN apt-get update && apt-get install -y build-essential \
    sudo \
    cmake \
    libboost-all-dev \
    libprotobuf-dev \
    protobuf-compiler \
    clang-3.6 \
    clang-format-3.6 \
    ninja-build \
    wget \
    unzip \
    zip \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# cppcheck
RUN cd /usr/local/src \
    && wget https://github.com/danmar/cppcheck/archive/1.79.tar.gz \
    && tar xvf 1.79.tar.gz \
    && cd cppcheck-1.79 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make install \
    && cd ../.. && rm -rf cppcheck*

RUN cd /usr/local/src \
    && wget https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 \
    && mv gosu-amd64 /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/gosu

ADD setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/setup.sh"]

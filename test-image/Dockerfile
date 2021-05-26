FROM ubuntu:20.04
# 20.04 latest LTS: Canonical will support it with updates until April 2025
# with extended security updates until April 2030

# install build tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    g++ \
    git \
    make

RUN git clone https://github.com/edenhill/librdkafka.git && \
    cd librdkafka && \
    ./configure && \
    make

RUN alias perf=/librdkafka/examples/rdkafka_performance

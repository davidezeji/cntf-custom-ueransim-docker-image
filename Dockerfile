FROM selenium/standalone-chrome as builder

USER root

ARG version=3.1.0

ENV VERSION=$version

ENV UNAME=$UNAME

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    make \
    g++ \
    libssl-dev \
    libcrypto++8 \
    libtls-dev \
    openssl \
    netcat \
    lksctp-tools \
    linux-headers-$UNAME

RUN cd /tmp && git clone https://github.com/aligungr/UERANSIM.git && \
    cd UERANSIM && git checkout tags/v$VERSION

RUN cd /tmp/UERANSIM && echo "cmake --version" && make

RUN cd /tmp && git clone https://github.com/Gradiant/openverso-images.git --depth=1

FROM selenium/standalone-chrome

COPY --from=builder /tmp/UERANSIM/build/* /usr/local/bin/

COPY --from=builder /tmp/openverso-images/etc/ueransim/* /etc/ueransim/

COPY --from=builder /tmp/openverso-images/entrypoint.sh /entrypoint.sh

USER root

RUN apt-get update && apt-get install -y \
    bind-tools \
    curl \
    get-text \
    iperf3 \
    iproute2 \
    liblksctp \
    libstdc++

USER 1200

ENV N2_IFACE=eth0
ENV N3_IFACE=eth0
ENV RADIO_IFACE=eth0
ENV AMF_HOSTNAME=amf
ENV GNB_HOSTNAME=localhost

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]


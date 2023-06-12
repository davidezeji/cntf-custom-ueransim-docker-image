FROM alpine:latest as builder

ARG version=3.1.0

ENV VERSION=$version

ENV UNAME=$UNAME

RUN apk add --no-cache \
    git \
    cmake \
    make \
    g++ \
    libressl-dev \
    lksctp-tools-dev \
    linux-headers-5.10.179-166.674.amzn2.x86_64n

RUN cd /tmp && git clone https://github.com/aligungr/UERANSIM.git && \
    cd UERANSIM && git checkout tags/v$VERSION 

    
RUN cd /tmp/UERANSIM && echo "cmake --version" && make

RUN cd /tmp && git clone https://github.com/aligungr/UERANSIM.git && \
    cd UERANSIM && git checkout tags/v$VERSION

RUN cd /tmp/UERANSIM && echo "cmake --version" && make

RUN cd /tmp && git clone https://github.com/Gradiant/openverso-images.git --depth=1


FROM alpine:latest

COPY --from=builder /tmp/UERANSIM/build/* /usr/local/bin/

COPY --from=builder /tmp/openverso-images/etc/ueransim/* /etc/ueransim/

COPY --from=builder /tmp/openverso-images/entrypoint.sh /entrypoint.sh



RUN apk add --no-cache \
    bash \
    bind-tools \
    curl \
    gettext \
    iperf3 \
    iproute2 \
    liblksctp \
    libstdc++

RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    dumb-init \
    udev \
    ttf-freefont \
    chromium \
    bash \
    bind-tools \
    curl \
    gettext \
    iperf3 \
    iproute2 \
    liblksctp \
    libstdc++ \
    && npm install puppeteer-core --silent \
      \
      # Cleanup
      && apk del --no-cache make gcc g++ python binutils-gold gnupg libstdc++ \
      && rm -rf /usr/include \
      && rm -rf /var/cache/apk/* /root/.node-gyp /usr/share/man /tmp/* \
      && echo

ENV CHROME_BIN="/usr/bin/chromium-browser"
ENV N2_IFACE=eth0
ENV N3_IFACE=eth0
ENV RADIO_IFACE=eth0
ENV AMF_HOSTNAME=amf
ENV GNB_HOSTNAME=localhost

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]int.sh"]
CMD ["/bin/sh"]


FROM alpine:latest as builder

ARG version=3.2.6

ENV VERSION=$version

RUN apk add --no-cache \
    git \
    cmake \
    make \
    g++ \
    libressl-dev \
    lksctp-tools-dev \
    linux-headers \
    build-base \
    alpine-sdk


RUN cd /tmp && git clone https://github.com/aligungr/UERANSIM.git && \
    cd UERANSIM && git checkout tags/v$VERSION 

    
RUN cd /tmp/UERANSIM && echo "cmake --version" && make

RUN cd /tmp && git clone https://github.com/Gradiant/openverso-images.git --depth=1


FROM node:20-alpine

COPY --from=builder /tmp/UERANSIM/build/* /usr/local/bin/

COPY --from=builder /tmp/openverso-images/images/ueransim/etc/ueransim/* /etc/ueransim/

COPY --from=builder /tmp/openverso-images/images/ueransim/entrypoint.sh /entrypoint.sh


WORKDIR /app #set the workdir to something other than / so the npm install doesn't fail

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

    && npm install puppeteer-core \
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

COPY *.js /app

WORKDIR / #set the workdir back so it doesn't break the entrypoint

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]


ARG FEDORA_MAJOR_VERSION="40"
ARG SOURCE_IMAGE="sericea"

ARG SOURCE_SUFFIX="-nvidia"

ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

COPY cosign.pub /usr/share/ublue-os/cosign.pub

COPY build.sh /tmp/build.sh
ADD --chmod=0755 scripts/* /tmp/

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

ADD root/ /
ARG FEDORA_MAJOR_VERSION="40"
ARG SOURCE_IMAGE="bluefin"

ARG SOURCE_SUFFIX="-dx-nvidia"

ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

COPY --from=ghcr.io/ublue-os/akmods:main-40 /rpms/ /tmp/akmods-rpms/

RUN find /tmp/akmods-rpms
RUN rpm-ostree install /tmp/akmods-rpms/ublue-os/ublue-os-akmods*.rpm
RUN rpm-ostree install /tmp/akmods-rpms/kmods/kmod-v4l2loopback*.rpm

COPY cosign.pub /usr/share/ublue-os/cosign.pub

COPY build.sh /tmp/build.sh
ADD --chmod=0755 scripts/* /tmp/

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

ADD root/ /
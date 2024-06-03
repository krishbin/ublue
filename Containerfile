ARG FEDORA_MAJOR_VERSION="40"
ARG SOURCE_IMAGE="bluefin"

ARG SOURCE_SUFFIX="-dx-nvidia"

ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

COPY --from=ghcr.io/ublue-os/akmods:main-40 /rpms/ /tmp/akmods-rpms/
COPY --from=ghcr.io/ublue-os/akmods:extra-40 /rpms/ /tmp/akmods-rpms/

RUN find /tmp/akmods-rpms
RUN sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_ublue-os-akmods.repo && \
    curl -Lo /etc/yum.repos.d/negativo17-fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo && \
    rpm-ostree install \
        /tmp/akmods-rpms/kmods/*xone*.rpm \
        /tmp/akmods-rpms/kmods/*openrazer*.rpm \
        /tmp/akmods-rpms/kmods/*v4l2loopback*.rpm \
        /tmp/akmods-rpms/kmods/*evdi*.rpm \
        /tmp/akmods-rpms/kmods/*ryzen-smu*.rpm && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo

COPY cosign.pub /usr/share/ublue-os/cosign.pub

COPY build.sh /tmp/build.sh
ADD --chmod=0755 scripts/* /tmp/

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

ADD root/ /
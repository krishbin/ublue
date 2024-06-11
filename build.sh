#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

rpm-ostree install git-lfs git-crypt libgit2

rpm-ostree install neovim

/tmp/install-1password.sh
/tmp/install-firefox.sh
/tmp/install-chrome.sh

# add cosign pub key
cp /usr/share/ublue-os/cosign.pub /usr/etc/pki/containers/cosign-krish.pub
FILE=/usr/etc/containers/policy.json
TMP=/tmp/policy.json

jq '.transports.docker |= 
    {"ghcr.io/krishbin": [
            {
                "type": "sigstoreSigned",
                "keyPath": "/usr/etc/pki/containers/cosign-krish.pub",
                "signedIdentity": {
                    "type": "matchRepository"
                }
            }
        ]
    }
+ .' $FILE > $TMP
mv -f $TMP $FILE

cp /usr/etc/containers/registries.d/ublue-os.yaml /usr/etc/containers/registries.d/ublue-krish.yaml
sed -i "s ghcr.io/ublue-os ghcr.io/krishbin g" /usr/etc/containers/registries.d/ublue-krish.yaml

rm -rf /usr/share/applications/nvim.desktop /usr/share/applications/remote-viewer.desktop /usr/share/applications/input-remapper-gtk.desktop

curl -Lo /etc/yum.repos.d/hardware:razer.repo https://download.opensuse.org/repositories/hardware:/razer/Fedora_$(rpm -E %fedora)/hardware:razer.repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo https://copr.fedorainfracloud.org/coprs/kylegospo/obs-vkcapture/repo/fedora-"${RELEASE}"/kylegospo-obs-vkcapture-fedora-"${RELEASE}".repo?arch=x86_64

rpm-ostree install openrazer-meta obs-vkcapture

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/hardware:razer.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo

echo 'import "/usr/share/ublue-os/just/61-krish.just"' >> /usr/share/ublue-os/justfile

# echo 'Installing vmware modules'
# wget https://github.com/krishbin/vmware_modules/releases/download/17.5.2_6.8/VmWare-kmods-17.5.2-1.fc40.x86_64.rpm -O /tmp/VmWare-kmods-17.5.2-1.fc40.x86_64.rpm

# rpm-ostree install /tmp/VmWare-kmods-17.5.2-1.fc40.x86_64.rpm
rpm-ostree install waydroid
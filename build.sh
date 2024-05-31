#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc
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

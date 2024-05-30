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
# rpm-ostree install kmod-openrazer kmod-xpadneo kmod-v4l2loopback kmod-xone 

# for REPO in $(rpm -ql ublue-os-akmods-addons|grep ^"/etc"|grep repo$); do
#   echo "akmods: enable default entry: ${REPO}"
#   sed -i.bak '0,/enabled=0/{s/enabled=0/enabled=1/}' ${REPO}
# done
# rpm-ostree install /tmp/akmods-rpms/*.rpm
# for REPO in $(rpm -ql ublue-os-akmods-addons|grep ^"/etc"|grep repo$); do
#   echo "akmods: restore defaults: ${REPO}"
#   mv ${REPO}.bak ${REPO}
# done

flatpak uninstall -y --system org.fedoraproject.MediaWriter
flatpak uninstall -y --system org.gnome.Calendar
flatpak uninstall -y --system org.gnome.Contacts
flatpak uninstall -y --system org.mozilla.Thunderbird
flatpak uninstall -y --system org.mozilla.Firefox

flatpak uninstall --unused -y

/tmp/install-1password.sh
/tmp/install-firefox.sh
/tmp/install-chrome.sh

rpm-ostree install gh neovim

rm -rf /usr/share/applications/nvim.desktop /usr/share/applications/remote-viewer.desktop

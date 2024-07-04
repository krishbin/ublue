#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

rpm-ostree install i3 i3status dmenu i3lock xbacklight feh xev conky alacritty autorandr xautolock playerctl python3.11
rpm-ostree install xss-lock network-manager-applet light maim xclip dunst polkit-gnome polybar rofi

# change /usr/bin/python3 to /usr/bin/python3.11 in /usr/bin/autorandr
sed -i 's|/usr/bin/python3|/usr/bin/python3.11|g' /usr/bin/autorandr


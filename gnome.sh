#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

rpm-ostree install i3 i3status dmenu i3lock xbacklight feh conky
rpm-ostree install xss-lock picom network-manager-applet light maim xclip dunst polkit-gnome polybar rofi
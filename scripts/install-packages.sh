#!/bin/bash

base="fish ranger neovim btop"
dev="qtcreator clion clion-lldb clion-jre clion-gdb clion-cmake clion-jre clang llvm docker git-open"
sys="alacritty plasma-systemmonitor kdeplasma-addons nextcloud-client keepassxc solaar wine wine-gecko wine-mono teams flatpak kwin-bismuth unclutter"
media="bitwig-studio renoise supercollider"

echo "Using: yay -Syu --needed --noconfirm $base $dev $sys $media" 

yay -Syu --needed --noconfirm $base $dev $sys $media

systemctl start docker
systemctl enable docker

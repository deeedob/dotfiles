#!/bin/bash

base="fish ranger neovim-nightly btop git-revise meld"
dev="qtcreator clion clang llvm docker git-open"
sys="alacritty plasma-systemmonitor kdeplasma-addons nextcloud-client keepassxc solaar wine wine-gecko wine-mono teams-for-linux flatpak kwin-bismuth unclutter ksshaskpass"
media="bitwig-studio renoise-demo supercollider discord-screenaudio"
appearance="kdeplasma-themes-kde-gruvbox-git klassy gtk-engine-murrine ttf-jetbrains-mono-nerd"

echo "Using: yay -Syu --needed --noconfirm $base $dev $sys $media $appearance" 

yay -Syu --needed --noconfirm "$base" "$dev" "$sys" "$media" "$appearance"

systemctl start docker
systemctl enable docker
systemctl start bluetooth
systemctl enable bluetooth

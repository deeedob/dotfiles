#!/bin/bash

base="fish ranger neovim-nightly btop git-revise meld"
dev="qtcreator clion clang llvm docker git-open nodejs"
sys="alacritty nextcloud-client keepassxc solaar wine wine-gecko wine-mono teams-for-linux flatpak"
wayland="wl-clipboard wev dunst polkit-kde-agent pipewire wireplumber qt5-wayland qt6-wayland hyprpaper dunst xdg-desktop-portal-hyprland-git rofi-lbonn-wayland"
media="bitwig-studio renoise-demo supercollider discord-screenaudio"
appearance="ttf-jetbrains-mono-nerd"

echo "Using: yay -Syu --needed --noconfirm $base $dev $sys $media $appearance $wayland"

yay -Syu --needed --noconfirm "$base" "$dev" "$sys" "$media" "$appearance" "$wayland"

systemctl start docker
systemctl enable docker
systemctl start bluetooth
systemctl enable bluetooth

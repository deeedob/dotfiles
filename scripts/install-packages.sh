#!/bin/bash

base="fish ranger neovim-nightly btop git-revise meld"
dev="qtcreator clion clang llvm docker git-open nodejs"
sys="alacritty nextcloud-client keepassxc solaar wine wine-gecko wine-mono teams-for-linux json-c dart-sass"
wayland="wl-clipboard wev dunst polkit-kde-agent pipewire wireplumber qt5-wayland qt6-wayland hyprpaper dunst xdg-desktop-portal-hyprland-git rofi-lbonn-wayland"
media="bitwig-studio renoise-demo supercollider discord-screenaudio obsidian"
appearance="ttf-jetbrains-mono-nerd ttf-material-design-icons"
eww="eww-wayland jaq brillo jc ttf-material-design-icons otf-jost" # TODO: Remove and desintegrate
waybar="betterlockscreen waybar hyprpicker-git candy-icons.git gtk-engine-murrine lxappearance"

echo "Using: yay -Syu --needed --noconfirm $base $dev $sys $media $appearance $wayland $eww"

yay -Syu --needed --noconfirm "$base" "$dev" "$sys" "$media" "$appearance" "$wayland" "$eww"

systemctl start docker
systemctl enable docker
systemctl start bluetooth
systemctl enable bluetooth

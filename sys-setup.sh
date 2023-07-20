#!/bin/bash

base="fish ranger neovim-nightly-bin btop git-revise meld bat"
dev="qtcreator clion visual-studio-code-bin clang llvm docker git-open nodejs json-c dart-sass "
sys="alacritty nextcloud-client keepassxc wine wine-gecko wine-mono teams qt6gtk2 qt6ct"
media="bitwig-studio supercollider discord-screenaudio obsidian soulseekqt" # renoise
appearance="ttf-jetbrains-mono-nerd ttf-material-design-icons-extended"
optional="clang14 llvm14 solaar polkit-kde-agent"

wayland="wl-clipboard wev dunst pipewire wireplumber qt5-wayland qt6-wayland hyprpaper xdg-desktop-portal-hyprland-git rofi-lbonn-wayland xremap-hypr-bin swaylock-effects-git wofi"
waybar="betterlockscreen waybar hyprpicker-git candy-icons-git gtk-engine-murrine lxappearance"

# Ask if packages should be installed
read -rp "Do you want to install packages? (y/n): " install_packages
if [[ $install_packages == "y" || $install_packages == "Y" ]]; then
    packages="$base $dev $sys $media $appearance $temporary $wayland $waybar"

    # Ask for subset of packages
    read -rp "Do you want to install all packages? (y/n): " install_all_packages
    if [[ $install_all_packages == "n" || $install_all_packages == "N" ]]; then
        read -rp "Enter the subset of packages to install (separated by spaces): " selected_packages
        packages="$selected_packages"
    fi

    echo "Using: yay -Syu --needed --noconfirm $packages"
    yay -Syu --needed --noconfirm "$packages"
else
    echo "Skipping package installation."
fi


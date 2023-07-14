#!/bin/bash

base="fish ranger neovim-nightly btop git-revise meld"
dev="qtcreator clion clang llvm docker git-open nodejs"
sys="alacritty nextcloud-client keepassxc solaar wine wine-gecko wine-mono teams-for-linux json-c dart-sass qt6qtk2 qt6ct"
media="bitwig-studio renoise-demo supercollider discord-screenaudio obsidian soulseek"
appearance="ttf-jetbrains-mono-nerd ttf-material-design-icons"

wayland="wl-clipboard wev dunst polkit-kde-agent pipewire wireplumber qt5-wayland qt6-wayland hyprpaper dunst xdg-desktop-portal-hyprland-git rofi-lbonn-wayland xremap"
waybar="betterlockscreen waybar hyprpicker-git candy-icons.git gtk-engine-murrine lxappearance"

# Ask if packages should be installed
read -rp "Do you want to install packages? (y/n): " install_packages
if [[ $install_packages == "y" || $install_packages == "Y" ]]; then
    packages="$base $dev $sys $media $appearance $wayland $waybar"

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


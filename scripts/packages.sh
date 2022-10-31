#!/usr/bin/zsh

echo "###############################"
echo "# WELCOME TO DDOB's DOTFILES! #"
echo "###############################"

parucmd="paru --noconfirm --needed -Syu tmux man-db zsh zsh-completions sudo git base-devel xorg-server xorg-xinit xorg-xmodmap xorg-xev xorg-xprop lightdm lightdm-webkit2-greeter lightdm-webkit-theme-osmos alacritty polybar sxhkd feh nautilus exa nmap python3 net-tools wget zoxide fzf ripgrep ranger xclip nodejs xorg-xsetroot gtk2 gtk3 gtk4 unclutter ueberzug lxappearance gpick imagemagick dunst bluez bluez-utils jq pacman-contrib gamemode eww-git moreutils playerctl tint2 gtk-engines gtk-engine-murrine system76-power blueberry btop starship flashfocus i3lock-color xqp jgmenu xfce4-power-manager xfce4-settings dmenu networkmanager-dmenu-git papirus-icon-theme nautilus-open-any-terminal-git conky-lua mate-polkit redshift bspwm-rounded-corners-git picom-pijulius-git bsp-layout xcursor-arch-cursor-c omplete pacutils expac alsa-utils accountsservice rofi lsof parcellite plocate firefox-developer-edition handlr npm luarocks go clang yarn pavucontrol acpi pulseaudio pulseaudio-alsa pulseaudio-bluetooth brightnessctl trash-cli xdg-user-dirs webkit2gtk xdo flameshot realtime-privileges tuned firewalld"

nvimdep="paru --noconfirm --needed -Syu cppcheck astyle uncrustify cmake-format ccls clazy python-pycodestyle python-pydocstyle"

if [ -n "$(command -v paru)" ]
  then
    # paru exists
    eval "$parucmd"
  else
    echo "installing paru aur helper"
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin;makepkg -si;cd ..;rm -rf paru-bin;
    sleep 1
    eval "$parucmd"
fi
addcmd="paru --needed -S baobab github-cli git-open keepassxc clion lldb subversion qt6 elementary-planner gnome-keyring gnome-calculator virt-manager qemu-full libvirt iptables-nft dnsmasq dmidecode bridge-utils openbsd-netcat ncmpcpp mpd wildmidi timidity++ python-pip"

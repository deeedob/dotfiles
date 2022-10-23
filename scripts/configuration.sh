#!/usr/bin/bash

sudo usermod -aG adm "$USER"

sudo systemctl enable --now com.system76.PowerDaemon
sudo systemctl enable bluetooth
sudo systemctl enable lightdm-plymouth.service

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

# oh-my-zsh
if [ ! -d "$HOME"/.config/zsh/oh-my-zsh/ ]; then
	echo "Downloading oh-my-zsh"
	ZSH="$HOME/.config/zsh/oh-my-zsh" sh "$HOME"/.config/zsh/install.sh
fi

echo "Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME"/.config/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# setup user Account Image for LightDM
printf "[User]\nXSession=bspwm\nIcon=/var/lib/AccountsService/icons/%s.jpg\nSystemAccount=false" "$(whoami)" | sudo tee /var/lib/AccountsService/users/"$(whoami)"

# setup touchpad
sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
EndSection

EOF

# set crontabs
#crontab ~/.scripts/crons.cron
#sudo crontab ~/.scripts/root-crons.cron

# set default mimes
handlr set x-scheme-handler/https firefoxdeveloperedition.desktop
handlr set x-scheme-handler/http firefoxdeveloperedition.desktop

# set lock screen
xfconf-query -c xfce4-session -p /general/LockCommand -s "$HOME/.scripts/lock" --create -t string

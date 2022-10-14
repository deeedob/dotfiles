#!/usr/bin/zsh


sudo usermod -aG adm $USER

sudo systemctl enable --now com.system76.PowerDaemon
sudo systemctl enable bluetooth
sudo systemctl enable lightdm-plymouth.service

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

# oh-my-zsh
cd ${BASEDIR}/files/.config/zsh/
ZSH="$HOME/.config/zsh/oh-my-zsh" sh install.sh
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/oh-my-zsh

# setup user Account Image for LightDM
echo "[USER]\nXSession=bspwm\nIcon=/var/lib/AccountsService/icons/$(whoami)\nSystemAccount=false" | sudo tee /var/lib/AccountsService/users/$(whoami)

#!/usr/bin/zsh


sudo usermod -aG adm $USER
sudo usermod -aG wheel $USER
sudo usermod -aG audio $USER

sudo plymouth-set-default-theme -R lone

sudo systemctl enable --now com.system76.PowerDaemon
sudo systemctl enable bluetooth
sudo systemctl enable lightdm-plymouth.service

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

# oh-my-zsh
cd $(pwd)/files/.config/zsh/
ZSH="$HOME/.config/zsh/oh-my-zsh" sh install.sh
cd $ZSH/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting

# setup user Account Image for LightDM
echo "[USER]\nXSession=bspwm\nIcon=/var/lib/AccountsService/icons/$(whoami)\nSystemAccount=false" | sudo tee /var/lib/AccountsService/users/$(whoami)

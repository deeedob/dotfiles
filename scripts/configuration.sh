#!/usr/bin/zsh


sudo usermod -aG adm $USER

sudo systemctl enable --now com.system76.PowerDaemon
sudo systemctl enable bluetooth
sudo systemctl enable lightdm-plymouth.service

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

# oh-my-zsh
cd ${BASEDIR}/files/.config/zsh/
if [ ! -d $HOME/.config/zsh/oh-my-zsh/ ]; then
  echo "Downloading oh-my-zsh"
  ZSH="$HOME/.config/zsh/oh-my-zsh" sh install.sh
fi

echo "Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# setup user Account Image for LightDM
echo "[USER]\nXSession=bspwm\nIcon=/var/lib/AccountsService/icons/$(whoami).jpg\nSystemAccount=false" | sudo tee /var/lib/AccountsService/users/$(whoami)

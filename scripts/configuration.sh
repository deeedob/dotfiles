#!/usr/bin/zsh


sudo usermod -aG adm $USER
sudo usermod -aG wheel $USER
sudo usermod -aG audio $USER

sudo plymouth-set-default-theme -R lone

sudo systemctl enable --now com.system76.PowerDaemon
sudo systemctl enable bluetooth
sudo systemctl enable lightdm-plymouth.service

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

echo "[USER]\nXSession=bspwm\nIcon=/var/lib/AccountsService/icons/$(whoami)\nSystemAccount=false" | sudo tee /var/lib/AccountsService/users/$(whoami)

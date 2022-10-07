#!/usr/bin/zsh


sudo usermod -aG adm $USER
sudo usermod -aG wheel $USER
sudo usermod -aG audio $USER


sudo systemctl enable --now com.system76.PowerDaemon
sudo systemctl enable bluetooth

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
sudo ln -s /usr/bin/alacritty /usr/bin/xterm


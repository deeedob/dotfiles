#!/bin/bash


yay -S --noconfirm --needed bottom nodejs ripgrep lazygit go gdu glsl-language-server

if [ -d ~/.config/nvim ]; then
  echo "Nvim is already installed!"
  echo "Please backup and remove your old config"
else
  echo "Installing AstroNvim"
  rm -rf ~/.local/share/nvim
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi

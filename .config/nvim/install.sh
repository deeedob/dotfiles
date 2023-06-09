#!/bin/bash

if [ -d ~/.config/nvim ]; then
  echo "Nvim is already installed!"
  echo "Please backup and remove your old config"
else
  echo "Installing AstroNvim"
  rm -rf ~/.local/share/nvim
  yay -S gdu bottom nodejs
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi

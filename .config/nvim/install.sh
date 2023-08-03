#!/bin/bash



if [ -d ~/.config/nvim ]; then
  echo "Nvim is already installed!"
  echo "Please backup and remove your old config"
else
  echo "Installing AstroNvim and required tools"
  yay -S bottom nodejs ripgrep lazygit go gdu glsl-language-server ctags
  rm -rf ~/.local/share/nvim
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi

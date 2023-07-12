#!/bin/bash

# Check if the default shell is already fish
if [[ $SHELL == "/usr/bin/fish" ]]; then
    echo "The default shell is already set to fish."
else
    chsh -s /usr/bin/fish
    echo "The default shell has been set to fish."
fi

if [ ! -d "$HOME"/.config/fish/ ]; then
  sudo pacman --noconfirm --needed -Syu fish fisher fzf fd bat zoxide exa yt-dlp trash-cli ripgrep

  currrent_dir=$PWD

  cd "$HOME"/.config/fish || exit

  fish -c 'fisher update'
  fish -c 'source config.fish'

  # switch default shell to fish
  chsh -s /usr/bin/fish

  echo "Successfully installed the fish shell"

  cd "$currrent_dir" || exit
else
  echo "Fish config already pre-existing. Abort."
fi


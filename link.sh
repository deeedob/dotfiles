#!/bin/bash

# TODO: switch to STOW? make sure folder exist at least...
# https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

set -e

ln -svrf ./Qt/CMakeMasterPresets.json ~/Qt/qt6/CMakePresets.json
ln -svrf ./Qt/.gitconfig ~/Qt/
ln -svrf ./Qt/setup.sh ~/Qt/

ln -svrf ./Libs/grpc/CMakePresets.json ~/Libs/src/grpc/
ln -svrf ./Libs/llvm-project/llvm/CMakePresets.json ~/Libs/src/llvm-project/llvm/

ln -svrf ./Wallpaper/ ~/
ln -svrf ./Scripts/ ~/
ln -svrf ./Bin/ ~/

ln -svrf .zshenv ~/
ln -svrf .ssh/config ~/.ssh/
ln -svrf .config/* ~/.config/

ln -svrf ./.local/share/dbus-1/ ~/.local/share/

sudo cp -r ./usr/share/icons/* /usr/share/icons/
sudo cp -r ./usr/share/themes/* /usr/share/themes/
sudo cp -r ./etc/restic/* /etc/restic/

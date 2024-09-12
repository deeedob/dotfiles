#!/bin/bash

set -e

ln -svrf ./Wallpaper/ ~/
ln -svrf ./Qt/CMakeMasterPresets.json ~/Qt/qt6/CMakePresets.json
ln -svrf ./Qt/.gitconfig ~/Qt/
ln -svrf ./Qt/setup.sh ~/Qt/
ln -svrf ./Scripts/ ~/
ln -svrf ./Bin/ ~/

ln -svrf .zshenv ~/
ln -svrf .ssh/config ~/.ssh/
ln -svrf .config/* ~/.config/

ln -svrf ./.local/share/dbus-1/ ~/.local/share/

sudo cp -r ./usr/share/icons/* /usr/share/icons/
sudo cp -r ./usr/share/themes/* /usr/share/themes/

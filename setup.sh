#!/bin/bash

echo "Setting up the system."

# Check if the default shell is already fish
if [[ $SHELL == "/usr/bin/fish" ]]; then
    echo "The default shell is already set to fish."
else
    chsh -s /usr/bin/fish
    echo "The default shell has been set to fish."
fi

cursor_theme="Bibata-Modern-TokyoNight"
if [ ! -d /usr/share/icons/${cursor_theme} ]; then
    sudo cp -r ../res/${cursor_theme} /usr/share/icons/
fi

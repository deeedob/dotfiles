#!/bin/bash

echo "Setting up the system."

cursor_theme="Bibata-Modern-TokyoNight"
if [ ! -d /usr/share/icons/${cursor_theme} ]; then
    sudo cp -r .res/${cursor_theme} /usr/share/icons/
fi

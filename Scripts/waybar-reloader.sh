#! /bin/bash

CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css $HOME/.config/waybar/custom/modules"

trap "killall waybar" EXIT

while true; do
    waybar -l debug &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done

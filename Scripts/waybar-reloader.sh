#! /bin/bash

CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.scss $HOME/.config/waybar/custom/modules"

trap "killall waybar" EXIT

while true; do
    waybar -l debug &
    inotifywait -e create,modify $CONFIG_FILES
    scss $HOME/.config/waybar/style.scss $HOME/.config/waybar/style.css
    killall waybar
done

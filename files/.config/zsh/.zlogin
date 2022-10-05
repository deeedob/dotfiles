# Following automatically calls "startx" when you login on tty1:
if [[ -z ${DISPLAY} && ${XDG_VTNR} -eq 1 ]]; then
    # Logs can be found in ~/.xorg.log
    exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
fi

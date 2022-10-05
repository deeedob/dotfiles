#!/bin/sh

# The following is essential, you need to source
# every file under `/etc/X11/xinit/xinitrc.d`.
if [[ -d /etc/X11/xinit/xinitrc.d ]] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        echo "Sourcing $f"
        [[ -x "$f" ]] && . "$f"
    done
    unset f
fi

sysresources=$HOME/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap

xrandr -s 1920x1080
exec bspwm

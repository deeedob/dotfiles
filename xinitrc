#!/bin/sh

#global vars
userresources=$HOME/.Xresources_d
usermodmap=$HOME/.Xmodmap_d
mycomputer="ddobs_desktop"
wallpaper_main_monitor="ign_leafHelmet.png"
wallpaper_second_monitor="archlinux.png"
soundcard=PCH

#::::::::::::::::::::::::::::System::::::::::::::::::::::::::::::::
setxkbmap de

# execute system shell scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Call .xprofile (All Global Vars live here)
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

#Custom Settings
if [ $mycomputer = "ddobs_desktop" ] ; then
    if [ -f $usermodmap ] ; then
        # set the keyboard layout
        $HOME/bin/setKeymap_desktop
    fi
    if [ -f $userresources ] ; then
        xrdb -merge ~/.Xresources
    fi
elif [ $mycomputer = "ddobs_laptop" ] ; then
    #set Touchpad settings
    xinput set-button-map 'ELAN0406:00 04F3:30A6 Touchpad' 1 3 2
    xinput -set-prop 'ELAN0406:00 04F3:30A6 Touchpad' 'libinput Tapping Enabled' 1
    xinput -set-prop 'ELAN0406:00 04F3:30A6 Touchpad' 'libinput Natural Scrolling Enabled' 0
    if [ -f $usermodmap ] ; then
        # set the keyboard layout
        $HOME/bin/setKeymap_desktop
    fi
    if [ -f $userresources ] ; then
        xrdb -merge ~/.Xresources
    fi

fi 

# setup gnome-keyring
eval $(gnome-keyring-daemon --start)
# setup SSH
eval "$(ssh-agent -s)"

#::::::::::::::::::::::::::::Applications:::::::::::::::::::::::::::

$HOME/bin/launch_polybar &

$HOME/bin/eww daemon &

/usr/bin/nextcloud &


#:::::::::::::::::::::::::::RICE::::::::::::::::::::::::::::::::::
#set wallpaper
root_wp_path=$HOME/Pictures/Wallpaper/nordic-wallpapers
feh --bg-scale $root_wp_path/$wallpaper_main_monitor --bg-scale $root_wp_path/$wallpaper_second_monitor

# set Cursor root
xsetroot -cursor_name left_ptr

#::::::::::::::::::::::::::Audio::::::::::::::::::::::::::::::::::
# Audio daemons
 /usr/bin/jackd -r -t1000 -dalsa -dhw:$soundcard -r44100 -p1024 -n3 &
 pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=2; pacmd set-default-sink jack_out

picom --experimental-backends &

exec bspwm

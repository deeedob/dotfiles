set -e

test -f ~/.profile && source ~/.profile

if uwsm check may-start && uwsm select; then
	exec uwsm start hyprland.desktop
fi

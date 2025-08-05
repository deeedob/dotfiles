#!/usr/bin/env zsh

test -f ~/.profile && source ~/.profile

case "$(uname)" in
Linux)
	if uwsm check may-start && uwsm select; then
		exec uwsm start hyprland.desktop
	fi
    ;;
Darwin)
    ;;
esac

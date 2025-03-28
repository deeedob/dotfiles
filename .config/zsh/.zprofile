set -e

test -f ~/.profile && source ~/.profile

source $HOME/Scripts/start-ssh-agent.sh

if uwsm check may-start && uwsm select; then
	exec uwsm start hyprland.desktop
fi

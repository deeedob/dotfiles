set -e

test -f ~/.profile && source ~/.profile

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export TERMINAL="kitty"
export USER_TERMINAL="kitty"

export USER_FILEMANAGER="nautilus"
export GOPATH="$XDG_DATA_HOME/go"

#export GTK_THEME="Kanagawa"
#export QT_QPA_PLATFORMTHEME="qt5ct"

source $HOME/Scripts/start-ssh-agent.sh

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland
fi

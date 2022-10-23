export TERMINAL="alacritty"
# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_DATA_HOME/cache"
export XDG_STATE_HOME="$XDG_DATA_HOME/state"

export GOPATH="$XDG_DATA_HOME/go"
# QUICK USER DIR
export prj="$HOME/User/Coding/Projects"

export EDITOR="nvim"
export VISUAL="nvim"
export GTK_THEME="Kanagawa-BL-LB"

#export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTTIMEFORMAT="[%F %T] "
export HISTSIZE=1000000
export SAVEHIST=1000000

# Man pages
export MANPAGER='nvim +Man!'

# System
export ARCHFLAGS="-arch x86_64"

# export gh token, user, weather key & id
FILE=~/User/Personal/Private/.glob_env ; [ -f $FILE ] && . $FILE

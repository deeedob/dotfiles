# PATH
export PATH="/usr/lib/ccache/bin:$PATH" # always use ccache
export PATH="$HOME/Bin/:$PATH"
export PATH="$HOME/Scripts/:$PATH"

# zsh
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# Man pages
export MANPAGER='nvim +Man!'

# Utility
export MAKEFLAGS="-j $(nproc --ignore=2)"
export CPPFLAGS="${CPPFLAGS} -fdiagnostics-color=always"
export CMAKE_GENERATOR="Ninja"
export QDOC_SHOW_INTERNAL="1"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -L'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export RESTIC_REPOSITORY="/mnt/backups/restic"
export RESTIC_PASSWORD_COMMAND="secret-tool lookup restic desktop-backup"

FZF_COLORS="bg+:-1,\
fg:gray,\
fg+:white,\
border:black,\
spinner:0,\
hl:yellow,\
header:blue,\
info:green,\
pointer:red,\
marker:blue,\
prompt:gray,\
hl+:red"

export FZF_DEFAULT_OPTS="--height 60% \
--border sharp \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"


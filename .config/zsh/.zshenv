#!/usr/bin/env zsh

function get_cores() {
  local cores

  if command -v nproc >/dev/null; then
    cores=$(nproc)
  elif command -v sysctl >/dev/null; then
    cores=$(sysctl -n hw.logicalcpu)
  else
    cores=$(grep -c '^processor' /proc/cpuinfo 2>/dev/null || echo 4)
  fi

  echo "$cores"
}

total_cores="$(get_cores)"
compile_cores=$(( total_cores > 2 ? total_cores - 2 : 1 ))
export COMPILE_CORES="$compile_cores"

export ZDOTDIR="$HOME/.config/zsh"
export ZCACHEDIR="${ZDOTDIR}/.cache"
[ -d "$ZCACHEDIR" ] || mkdir -p "$ZCACHEDIR"
export ZSH_COMPDUMP="$ZCACHEDIR/zcompdump"

# PATH
if [[ "$OSTYPE" == darwin* ]]; then
    # Disable "Save/Restore Shell State" i.e. ".zsh_sessions"
    export SHELL_SESSIONS_DISABLE=1
else
    export PATH="/usr/lib/ccache/bin:$PATH"
    export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
    export RESTIC_REPOSITORY="/mnt/backups/restic"
    export RESTIC_PASSWORD_COMMAND="secret-tool lookup restic desktop-backup"
fi

export PATH="$HOME/Bin/:$PATH"
export PATH="$HOME/Scripts/:$PATH"

# Man pages
export MANPAGER='nvim +Man!'

# Utility
export MAKEFLAGS="-j ${COMPILE_CORES}"
export CPPFLAGS="${CPPFLAGS} -fdiagnostics-color=always"
export CMAKE_GENERATOR="Ninja"
export QDOC_SHOW_INTERNAL="1"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"

export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim -u NONE"
export BROWSER="firefox"
export TERMINAL="kitty"
export USER_TERMINAL="kitty"
export USER_FILEMANAGER="nautilus"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f -L'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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


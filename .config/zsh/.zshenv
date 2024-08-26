# PATH
export PATH="$HOME/Bin/:$PATH"
export PATH="$HOME/Scripts/:$PATH"

# Function to find the best qmlls binary
add_best_qmlls_to_path() {
    # Define the base directory
    base_dir="$HOME/Qt/qt6/build"

    # Check for possible build variants
    variants=("release-clang" "release-gcc" "debug-clang" "debug-gcc")

    # Variable to store the best found qmlls path
    best_qmlls=""

    for variant in "${variants[@]}"; do
        qmlls_path="$base_dir/$variant/qtbase/bin/qmlls"
        if [ -f "$qmlls_path" ]; then
            if [ -z "$best_qmlls" ] || [ "$qmlls_path" -nt "$best_qmlls" ]; then
                best_qmlls="$qmlls_path"
            fi
        fi
    done

    # If a qmlls binary was found, add its directory to the PATH
    if [ -n "$best_qmlls" ]; then
        export PATH="$(dirname "$best_qmlls"):$PATH"
    fi
}

# Call the function to update the PATH
add_best_qmlls_to_path

# SSH
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# editor
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim -u NONE"

# zsh
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# Man pages
export MANPAGER='nvim +Man!'

# Utility
export MAKEFLAGS="-j $(nproc --ignore=1)"
export QDOC_SHOW_INTERNAL="1"

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


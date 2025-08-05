#!/usr/bin/env zsh
# https://thevaluable.dev/zsh-install-configure-mouseless/

# Export here as '/etc/zshrc' will set it aswell. Therefore zshenv doesnt work.
export HISTFILE="$ZCACHEDIR/zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

plugin_base=""
if [[ "$OSTYPE" == darwin* ]]; then
    if command -v brew >/dev/null 2>&1; then
        plugin_base="$(brew --prefix)/share"
        fpath=($plugin_base/zsh/site-functions $fpath)
        export PATH="$(brew --prefix rustup)/bin:$PATH"
        export PATH="$(brew --prefix ccache)/libexec:$PATH"
        export CMAKE_PREFIX_PATH="$(brew --prefix)"
        export MACOSX_DEPLOYMENT_TARGET="$(sw_vers -productVersion)"
    else
        echo "brew is not installed!"
    fi
else
    plugin_base="/usr/share/zsh/plugins"
fi

# Load additional completions from zsh-completions
fpath=(/usr/share/zsh/site-functions/ $fpath)

# +---------+
# | PLUGINS |
# +---------+

syntax_highlighting="$plugin_base/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
autosuggestions="$plugin_base/zsh-autosuggestions/zsh-autosuggestions.zsh"
history_search="$plugin_base/zsh-history-substring-search/zsh-history-substring-search.zsh"

if [[ -f "$syntax_highlighting" ]]; then
    source $syntax_highlighting
    fast-theme -q sv-orple
else
    echo "Plugin: $syntax_highlighting is missing!"
fi

if [[ -f "$autosuggestions" ]]; then
    source $autosuggestions
else
    echo "Plugin: $autosuggestions is missing!"
fi

if [[ -f "$history_search" ]]; then
    source $history_search
else
    echo "Plugin: $history_search is missing!"
fi

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY        # don’t wait for shell to exit to save history lines
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_REDUCE_BLANKS        # strip superfluous blanks

# +--------+
# | COLORS |
# +--------+

# Override colors
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b $ZDOTDIR/dircolors)"
fi

# +---------+
# | ALIASES |
# +---------+

source $ZDOTDIR/aliases

# +---------+
# | SCRIPTS |
# +---------+

source $ZDOTDIR/scripts.zsh

# +--------+
# | PROMPT |
# +--------+

source $ZDOTDIR/prompt.zsh

# +-----------+
# | VI KEYMAP |
# +-----------+

# Vi mode
bindkey -v
if [[ "$OSTYPE" == darwin* ]]; then
    # Fix MacOs issues with zsh-autosuggestions and vi-mode
    bindkey -v '^?' backward-delete-char
    bindkey -v '^H' backward-delete-char
fi
export KEYTIMEOUT=1

# Change cursor
source "$ZDOTDIR/plugins/cursor_mode"

# Add Vi text-objects for brackets and quotes
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Emulation of vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround


# +------------+
# | COMPLETION |
# +------------+
source $ZDOTDIR/completion.zsh

# +-----+
# | FZF |
# +-----+

if [ $(command -v "fzf") ]; then
    source $ZDOTDIR/fzf.zsh
fi

# +---------+
# | BINDING |
# +---------+

# edit current command line with vim (vim-mode, then CTRL-v)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# +---------+
# | VARIOUS |
# +---------+

# fixes annoying completion duplicates for cd
# https://github.com/ajeetdsouza/zoxide/issues/491#issuecomment-2137626085
eval "$(zoxide init --cmd cd zsh | sed 's/_files/_cd/g')"

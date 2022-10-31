#
# Oh-My-Zsh Configs
#
export ZSH="$ZDOTDIR/oh-my-zsh"
ZSH_THEME="arrow"
ENABLE_CORRECTIONS="true"

plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
  ssh-agent
  virtualenv
  git
	sudo
	colored-man-pages
)
source $ZSH/oh-my-zsh.sh
#
# Zsh configs
#

## completions 
## see @ man zshcompsys
autoload -Uz compinit; compinit
_comp_options+=(globdots) #with hidden files

## zstyle <pattern> <style> <value>
## pattern = :completion:<function>:<completer>:<command>:<argument>:<tag>
## show help wilst in completion with: CTRL+x h
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompcache"
#zstyle ':completion:*' group-name ''
zstyle ':completion:*' complete true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' keep-prefix true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
zstyle ':completion:*:*:cp:*' file-sort modification
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

## binding
### expand alias on CTRL+a
zle -C alias-expension complete-word _generic
bindkey '^a' alias-expension 
zstyle ':completion:alias-expension:*' completer _expand_alias

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'n' accept-and-infer-next-history
bindkey -M menuselect 'b' undo
bindkey -M menuselect 'i' vi-insert

#bindkey -s '^[[200~' '' # fix keybinding gets triggered when pasting text 

## options
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

## colors
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:*:*:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 

## history search
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

#
# User configs
#
source $ZDOTDIR/.zaliases
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

## term colors
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[unkown-token]=fg=#cc626a
ZSH_HIGHLIGHT_STYLES[path]=fg=#afb2bb
ZSH_HIGHLIGHT_STYLES[alias]=fg=#c678dd,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#d1b071,standout
ZSH_HIGHLIGHT_STYLES[command]=fg=#61afef,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=#89b06d

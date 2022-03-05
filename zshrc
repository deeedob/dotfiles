if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#_______________System_________________
# load aliases
source ~/.bash_aliases
export ZSH=/usr/share/oh-my-zsh
#_______________ohmyzsh Setting _________________
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# History
export HISTFILE=~/.oh-my-zsh/histfile
export HISTFILESIZE=10000 #store 1 billion commands
export HISTSIZE=1000 
# immediate append
# setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY #timestamp history
setopt HIST_IGNORE_ALL_DUPS #ignore dups
setopt COMPLETE_ALIASES
# Disable correction
unsetopt correct_all
unsetopt correct
DISABLE_CORRECTION="true" 
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Export
export ZSH=/usr/share/oh-my-zsh
export EDITOR="nvim"
export TERM="alacritty"

#############################
######## plugins ############
plugins=(
  #zsh-history-substring-search
  zsh-autosuggestions 
  zsh-syntax-highlighting 
  zsh-autocomplete
  colored-man-pages
  sudo
  web-search # <context> <term>
  copydir #copydir to buffer
  copyfile # copyfile to buffer
  copybuffer # ctrl + o to copy current buffer 
  dirhistory # alt left + right to go dirup dirdown
  colored-man-pages 
  command-not-found 
  cp 
  #zsh-vi-mode
)
# use zoxide as cd command
eval "$(zoxide init zsh)"

source $ZSH/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh


#_________________KEYS___________________
#zsh autocomplete
#bindkey '\e[A' up-line-or-search
#bindkey '\eOA' up-line-or-search
#bindkey '\e[B' down-line-or-select
##bindkey '\eOB' down-line-or-select
#bindkey '\0' list-expand
#bindkey -M menuselect '\r' .accept-line
# set Keys 
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history

#::::::::::::::::zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#cc626a
ZSH_HIGHLIGHT_STYLES[path]=fg=#afb2bb
ZSH_HIGHLIGHT_STYLES[alias]=fg=#c678dd,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#d1b071,standout
ZSH_HIGHLIGHT_STYLES[command]=fg=#61afef,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=#89b06d
#ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#00ff00,underline
#ZSH_HIGHLIGHT_STYLES[default]=#8E94A3
#ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
#ZSH_HIGHLIGHT_STYLES[builtin]=fg=#A463BF,bold
#ZSH_HIGHLIGHT_STYLES[function]=fg=#98c379,bold
#ZSH_HIGHLIGHT_STYLES[commandseparator]=none
#ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
#ZSH_HIGHLIGHT_STYLES[globbing]=fg=#A463BF
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#98c379
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#98c379
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=#98c379
#ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=#98c379
#ZSH_HIGHLIGHT_STYLES[assign]=none
#::::::::::::::::zsh-autosuggestions::::::::::::::::::::
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
bindkey '^ ' autosuggest-accept # ctrl + space to accept suggestion
#::::::::::::::::zsh-autocomplete::::::::::::::::::::
# Wait until this many characters have been typed, before showing completions.
zstyle ':autocomplete:*' min-input 1  # int

zstyle ':autocomplete:*' recent-dirs cdr
# cdr:  Use Zsh's `cdr` function to show recent directories as completions.
# no:   Don't show recent directories.
# zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).

zstyle ':autocomplete:*' widget-style menu-complete
# complete-word: (Shift-)Tab inserts the top (bottom) completion.
# menu-complete: Press again to cycle to next (previous) completion.
# menu-select:   Same as `menu-complete`, but updates selection in menu.

zstyle ':autocomplete:*' fzf-completion no
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# have installed Fzf's shell extensions.

#:::::::::::::::OPTIONS:::::::::::::::::::::::
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
#_________________USER CONFIG _____________________
export ARCHFLAGS="-arch x86_64"

source $ZSH/oh-my-zsh.sh

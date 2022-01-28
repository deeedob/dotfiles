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
export HISTFILESIZE=1000000000 #store 1 billion commands
export HISTSIZE=1000000000 
# immediate append
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY #timestamp history
setopt HIST_IGNORE_ALL_DUPS #ignore dups
setopt COMPLETE_ALIASES
# Disable correction
unsetopt correct_all
unsetopt correct
DISABLE_CORRECTION="true" 
export TERM="alacritty"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Export
export ZSH=/usr/share/oh-my-zsh
export EDITOR="nvim"

#############################
######## plugins ############
plugins=(
  zsh-history-substring-search
  zsh-autosuggestions 
  zsh-syntax-highlighting 
  zsh-autocomplete
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


#_________________KEYS___________________
#autoload -U history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^[[A" history-beginning-search-backward-end
#bindkey "^[[B" history-beginning-search-forward-end
#
source $ZSH/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh


#autoload -U history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^[[A" history-beginning-search-backward-end
#bindkey "^[[B" history-beginning-search-forward-end

#::::::::::::::::zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[default]=#8E94A3
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#e06c75
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=#A463BF,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#A463BF,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=#A463BF,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=#7EA566,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=#C09E64,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=#A463BF
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#C09E64,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#98c379
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#98c379
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=#98c379
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=#98c379
ZSH_HIGHLIGHT_STYLES[assign]=none
#::::::::::::::::zsh-autosuggestions::::::::::::::::::::
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
bindkey '^ ' autosuggest-accept # ctrl + space to accept suggestion
#::::::::::::::::zsh-autocomplete::::::::::::::::::::
# Wait until this many characters have been typed, before showing completions.
zstyle ':autocomplete:*' min-input 1  # int

zstyle ':autocomplete:*' recent-dirs zoxide
# cdr:  Use Zsh's `cdr` function to show recent directories as completions.
# no:   Don't show recent directories.
# zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).

zstyle ':autocomplete:*' widget-style menu-complete
# complete-word: (Shift-)Tab inserts the top (bottom) completion.
# menu-complete: Press again to cycle to next (previous) completion.
# menu-select:   Same as `menu-complete`, but updates selection in menu.

zstyle ':autocomplete:*' fzf-completion yes
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# have installed Fzf's shell extensions.

#:::::::::::::::OPTIONS:::::::::::::::::::::::
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#_________________USER CONFIG _____________________
export ARCHFLAGS="-arch x86_64"


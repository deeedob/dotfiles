# Shortcuts for common Git commands
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gs='git status'
alias gb='git branch'
alias gd='git diff'
# Git last commits's files
alias glcf='git show --pretty="format:" --name-only HEAD'

# Show Git log in a compact format
alias gl='git log --oneline --decorate --graph'

# Show the current Git branch name
alias gbr='git branch --show-current'
# List all local branches with colors
alias gbrl='git branch --format "%(refname:short)" | awk "{print \"\033[32m\"\$1\"\033[0m\"}"'


# Undo the last commit (use with caution!)
alias undo='git reset HEAD~'

# Show a colored Git branch in the terminal prompt
function parse_git_branch
  echo (git branch --show-current 2> /dev/null | sed -e 's/\*//')
end
set -x fish_prompt (parse_git_branch)' $ '

# Update submodule
alias gsu='git submodule update --init --recursive'

# Git remotes
alias gr='git remote -v | awk "{print \"\033[32m\"\$1\"\033[0m\t\033[33m\"\$2\"\033[0m\"}"'
alias grrm="git remote rm"
alias gra="git remote add"

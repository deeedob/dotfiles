# Prompt
set fish_greeting

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    set_color $fish_color_user
    echo -n (whoami)
    echo -s "@ " $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end

# Variables

fish_add_path /usr/lib/qt6/bin
fish_add_path ~/bin
set -x CC clang
set -x CXX clang++
set -x CMAKE_EXPORT_COMPILE_COMMANDS 1
set -x QDOC_SHOW_INTERNAL 1

set -x EDITOR nvim
set -x GIT_EDITOR $EDITOR
set -x MANPAGER "nvim +Man!"

# Aliases

# Main
if [ -f $HOME/.config/fish/aliases/main.fish ]
    source $HOME/.config/fish/aliases/main.fish
end
# Git
if [ -f $HOME/.config/fish/aliases/git.fish ]
    source $HOME/.config/fish/aliases/git.fish
end

# Function

function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function builder
    cmake --build cmake-builder -G Ninja
end

function grepcc
  grep -Rnw --include="*.cpp" --include="*.h" . -e $argv
end

function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"
  if set --query TMUX
    fzf-tmux $argv
  else
    command fzf $argv
  end
end

# Settings
zoxide init --cmd cd fish | source

fzf_configure_bindings \
    --directory=\cf --git_log=\cl --git_status=\cs \
    --history=\ch --processes=\cp --variables=\cv


#!/usr/bin/env fish
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
set -x EDITOR nvim
set -x GIT_EDITOR $EDITOR
set -x SUDO_EDITOR "rvim -u NONE"
set -x MANPAGER "nvim +Man!"

set -x QDEV $HOME/Qt/qt6/build/debug/qtbase
# For Debugging QT
set -x QDOC_SHOW_INTERNAL 1
# set -x QT_DEBUG_PLUGINS 1
# set -x QML_IMPORT_TRACE 1

# extend PATH
if [ -d $QDEV/bin ]
    fish_add_path -p $QDEV/bin
end
fish_add_path -a /usr/lib/qt6/bin
fish_add_path -a $HOME/Bin
fish_add_path -a $HOME/Scripts


# Aliases
## Main
if [ -f $HOME/.config/fish/aliases/main.fish ]
    source $HOME/.config/fish/aliases/main.fish
end
## Git
if [ -f $HOME/.config/fish/aliases/git.fish ]
    source $HOME/.config/fish/aliases/git.fish
end

# Functions
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function builder
    if set -q CMAKE_PREFIX_PATH
        set -e CMAKE_PREFIX_PATH
        echo "-- CMAKE_PREFIX_PATH: $CMAKE_PREFIX_PATH"
    end
    cmake --fresh -G Ninja -D CMAKE_EXPORT_COMPILE_COMMANDS=ON -B builder/ && cmake --build builder
    ln -snf builder/compile_commands.json .
    set -x CMAKE_PREFIX_PATH $QDEV
end

# Qt Dev Builder
function qdevbuilder
    # Print available libQt6*.so libraries
    if set -q QDEV
        echo "-- QDEV PATH: $QDEV"
        set -x CMAKE_PREFIX_PATH $HOME/Qt/qt6/build/default/qtbase/lib/cmake
    end
    builder
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


#!/bin/bash

if [ ! -f "./init-repository" ]; then
    echo "init-repository not found in current directory!"
    exit 1
fi

cmake_base_preset=~/Dotfiles/Qt/CMakePresets.json
if [ ! -f $cmake_base_preset ]; then
    echo "Did not find in $cmake_base_preset!"
    exit 1
fi
git submodule foreach "ln -svrf '$cmake_base_preset' . || true"

read -rp "Update Qt to dev? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    git submodule foreach "git checkout dev || true"
    git submodule foreach "git pull || true"
fi

read -rp "Do you want to install the dependencies? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    yay -S --needed --noconfirm lttng-ust libxcb xdb-proto xcb-util xcb-util-image xcb-util-wm libxi renderdoc-bin mysql postgresql oracle-instantclient-sdk unixodbc ccache mariadb llvm gperf python-html5lib fontconfig openxr libwmf
fi

#!/bin/bash

set -e

if [ ! -f "./init-repository" ]; then
    echo "init-repository not found in current directory!"
    exit 1
fi

cmake_repo_preset=~/Qt/CMakePresets.json
cmake_master_preset=~/Qt/CMakeMasterPresets.json

if [ ! -f "$cmake_repo_preset" ]; then
    echo "Repo preset not found: $cmake_repo_preset"
    exit 1
fi

if [ ! -f "$cmake_master_preset" ]; then
    echo "Master preset not found: $cmake_master_preset"
    exit 1
fi

ln -sf "$cmake_master_preset" CMakePresets.json

base_repos=(qtrepotools qtbase qtdeclarative qtimageformats qtshadertools qtsvg qtgrpc qttools)
for repo in "${base_repos[@]}"; do
    git submodule update --init --recursive "$repo"
    ln -sf "$cmake_repo_preset" "$repo/CMakePresets.json"
done

read -rp "Checkout and update all repos to a specific branch (e.g. dev)? [empty to skip]: " branch
if [ -n "$branch" ]; then
    echo "Checking out branch '$branch'..."

    git fetch origin "$branch"
    git checkout -B "$branch" "origin/$branch" || echo "Main repo: branch '$branch' not found"

    git submodule foreach "
        if [ \"\$name\" != \"qtrepotools\" ]; then
            git fetch origin $branch
            git checkout -B $branch origin/$branch || echo \"\$name: branch '$branch' not found\"
            git submodule update --init --recursive
        fi"
fi

if [[ "$(uname)" == "Linux" ]]; then
    read -rp "Do you want to install the dependencies? [y/N] " response
    if [[ "$response" =~ ^[yY]([eE][sS])?$ ]]; then
        yay -S --needed --noconfirm \
            lttng-ust libxcb xdb-proto xcb-util xcb-util-image \
            xcb-util-wm libxi renderdoc-bin mysql postgresql \
            oracle-instantclient-sdk unixodbc ccache mariadb \
            llvm gperf python-html5lib fontconfig openxr libwmf
    fi
fi


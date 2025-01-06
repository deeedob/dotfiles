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

# print all directory names that start with qt and copy the preset file
for dir in `find -maxdepth 1 -name "qt*" -type d`; do
    if [ "$(ls -A "$dir")" ]; then
        ln -svrf "$cmake_base_preset" "$dir/CMakePresets.json"
    else
        echo "Skipping empty directory: $dir"
    fi
done

read -rp "Do you want to install the dependencies? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    yay -S --needed --noconfirm lttng-ust libxcb xdb-proto xcb-util xcb-util-image xcb-util-wm libxi renderdoc-bin mysql postgresql oracle-instantclient-sdk unixodbc ccache mariadb llvm gperf python-html5lib fontconfig openxr libwmf
fi

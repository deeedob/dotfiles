#!/bin/bash

if [ ! -f "./init-repository" ]; then
    echo "init-repository not found in current directory!"
    exit 1
fi

cmake_base_preset=~/Dotfiles/Qt/CMakeBasePresets.json
if [ ! -f $cmake_base_preset ]; then
    echo "CMakeBasePresets.json not found in $cmake_base_preset!"
    exit 1
fi

# print all directory names that start with qt and copy the preset file
for dir in `find -name "qt*" -type d -maxdepth 1`; do
    cp $cmake_base_preset $dir/CMakePresets.json
    echo "Copied $cmake_base_preset to $dir/CMakePresets.json"
done

read -rp "Do you want to install the dependencies? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    yay -Syu --needed --noconfirm lttng-ust libxcb renderdoc-bin mysql postgresql oracle-instantclient-sdk unixodbc
fi

read -rp "Enter your codereview username: " codereview_username
read -rp "Is this correct? $codereview_username [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    ./init-repository --codereview-username dennisoberst -f
fi


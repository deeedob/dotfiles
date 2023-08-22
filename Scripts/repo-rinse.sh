#!/bin/bash

# Ask for confirmation
read -p "Are you sure you want to reset all submodules? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

git clean -xfd
git submodule foreach --recursive git clean -xf
git reset --hard
git submodule foreach --recursive git reset --hard
git submodule update --init --recursive

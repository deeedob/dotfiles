#!/bin/bash

# Ask for confirmation
read -p "Are you sure you want to update all submodules to dev branch? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

git submodule foreach 'git checkout dev -f || true'
git submodule foreach 'git pull || true'


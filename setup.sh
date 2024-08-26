#!/bin/bash

packages=$(grep -v '^\s*$' pkgs | tr '\n' ' ')

echo "installing ${packages}"
yay -Syu --needed --noconfirm "${packages}"

services="docker.socket bluetooth.service"
uservices="ssh-agent.service"

systemctl enable "${services}"
systemctl enable --user "${uservices}"

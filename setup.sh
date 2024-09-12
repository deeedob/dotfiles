#!/bin/bash

set -e

packages=$(grep -v '^\s*$' pkgs | tr '\n' ' ')

echo "Running CMD: yay -Syu --needed ${packages}"
yay -Syu --needed ${packages}

services="docker.socket bluetooth.service"
uservices="ssh-agent.service pipewire-pulse.service"

systemctl enable "${services}"
systemctl enable --user "${uservices}"

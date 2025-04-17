#!/bin/bash

set -e

packages=$(grep -v '^\s*$' pkgs | tr '\n' ' ')

echo "Running CMD: yay -Syu --needed ${packages}"
yay -Syu --needed ${packages}

system_services=(
    docker.socket
    bluetooth.service
    ananicy-cpp
    irqbalance
    nohang
    preload
    prelockd
    uresourced
)

user_services=(
    ssh-agent.service
    pipewire-pulse.service
)

echo "Enabling system services if not already enabled..."
for svc in "${system_services[@]}"; do
    if ! systemctl is-enabled --quiet "$svc"; then
        echo "Enabling $svc..."
        sudo systemctl enable "$svc"
    else
        echo "$svc is already enabled."
    fi
done

echo "Enabling user services if not already enabled..."
for usvc in "${user_services[@]}"; do
    if ! systemctl --user is-enabled --quiet "$usvc"; then
        echo "Enabling $usvc..."
        systemctl --user enable "$usvc"
    else
        echo "$usvc is already enabled."
    fi
done

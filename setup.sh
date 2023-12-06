#!/bin/bash

echo "Setting up the system."

cursor_theme="Bibata-Modern-TokyoNight"
if [ ! -d /usr/share/icons/${cursor_theme} ]; then
    sudo cp -r .res/${cursor_theme} /usr/share/icons/
fi

if find $HOME/.themes -mindepth 1 -maxdepth 1 | read; then
    echo ".themes order is not empty. Omitting Theme and Icon install"
else
    $HOME/Dotfiles/.third-party/symlink_themes.sh
fi

# enable ptrace for gdb globally
ptrace_file="/etc/sysctl.d/10-ptrace.conf"
if [ ! -f "$ptrace_file" ]; then
    echo "kernel.yama.ptrace_scope = 0" | sudo tee "$ptrace_file"
fi

# install xremap and set is as service to get custom keybinds.
sudo make -C .config/xremap 1> /dev/null

# gh-dash extension
gh extension install dlvhdr/gh-dash

check_enable_start_service() {
    local service=$1

    # Check if the service is enabled
    if systemctl is-enabled "$service" >/dev/null 2>&1; then
        echo "Service '$service' is already enabled."
    else
        echo "Enabling service '$service'..."
        if sudo systemctl enable "$service" >/dev/null 2>&1; then
            echo "Service '$service' has been enabled."
        else
            echo "Failed to enable service '$service'."
        fi
    fi

    # Check if the service is running
    if systemctl is-active "$service" >/dev/null 2>&1; then
        echo "Service '$service' is already running."
    else
        echo "Starting service '$service'..."
        if sudo systemctl start "$service" >/dev/null 2>&1; then
            echo "Service '$service' has been started."
        else
            echo "Failed to start service '$service'."
        fi
    fi
}

check_enable_start_service "docker"
check_enable_start_service "bluetooth"
check_enable_start_service "xremap"
check_enable_start_service "pkgstats.timer"


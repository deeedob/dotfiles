#!/bin/bash

SSH_ENV="$XDG_RUNTIME_DIR/ssh-agent.env"

# Function to check for ssh-agent, excluding this script
check_ssh_agent() {
    pgrep -u "$USER" ssh-agent | grep -v $$ > /dev/null
}

if ! check_ssh_agent; then
    ssh-agent -t 1h > "$SSH_ENV"
    echo "SSH Agent: Started new instance"
fi

if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    source "$SSH_ENV" > /dev/null
    echo "SSH Agent: Loaded environment"
    if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
        echo "SSH Agent: Failed to load ssh-agent environment."
        exit 1
    fi
fi

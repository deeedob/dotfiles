#!/bin/sh
[ -n "$SSH_AGENT_PID" ] || eval "$(ssh-agent -s)"
SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS

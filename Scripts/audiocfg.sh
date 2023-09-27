#!/bin/bash

# Change between different audio configurations on linux
# Driver: Alsa
# Sound server: Jackd, PipeWire, PulseAudio


pkgs="realtime-privileges pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack wireplumber"
yay -S --needed $pkgs

# add user to realtime group
sudo usermod -a -G realtime $USER

# Check current audio configuration
pactl info

# Kill all running audio servers
killall -9 jackd
killall -9 pulseaudio
killall -9 pipewire

# Start Jackd


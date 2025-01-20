#!/bin/bash

pactl load-module module-null-sink sink_name=bitwig_and_mic sink_properties=device.description="BitwigAndMic"
pw-link "Bitwig Studio:Speakers_L" "bitwig_and_mic:playback_FL"
pw-link "Bitwig Studio:Speakers_R" "bitwig_and_mic:playback_FR"
pw-link "alsa_input.usb-046d_Brio_500_2419LZ5101G8-02.analog-stereo:capture_FL" "bitwig_and_mic:playback_FL"
pw-link "alsa_input.usb-046d_Brio_500_2419LZ5101G8-02.analog-stereo:capture_FR" "bitwig_and_mic:playback_FR"

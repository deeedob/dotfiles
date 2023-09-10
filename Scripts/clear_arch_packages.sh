#!/bin/bash

before=$(date +%s -d "now -6 months")

exclude="base grub"
exclude_groups="base-devel[ ]|xfce4[ ]"

pacman -Qttlq \
    | grep -v '/$' \
    | xargs -d \\n stat -c "%X %n" 2>/dev/null \
    | awk -v T=$before '$1 > T { $1=""; print substr($0,2); }' \
    | tr '\n' '\0'\
    | xargs -0 pacman -Qqo \
    | sort -u >| /tmp/recently_used

pacman -Qttq | sort | comm -13 /tmp/recently_used - \
    | grep -Ev $(echo $exclude | tr ' ' '|' ) \
    | grep -vFf <(pacman -Qg | grep -E "^($exclude_groups)" | cut -f2 -d' ')

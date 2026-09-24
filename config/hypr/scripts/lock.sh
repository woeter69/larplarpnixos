#!/usr/bin/env bash

# Pre-fetch album art before locking
~/.config/hypr/scripts/albumart.sh > /dev/null 2>&1

# Launch lockscreen (hyprlock if installed, otherwise swaylock)
if command -v hyprlock &>/dev/null; then
    hyprlock
else
    swaylock -f
fi

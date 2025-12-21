#!/bin/bash
# Linux equivalent of Hammerspoon toggle for wuake

# Check if wuake GUI is running
if pgrep -f "wezterm-gui connect wuake" >/dev/null; then
    pkill -9 -f "wezterm-gui connect wuake"
    exit 0
fi

# Start wuake
exec wezterm connect wuake

#!/usr/bin/env bash
# Fuzzel-based power menu for niri

# Power options
options=(
  "󰌾 Lock"
  "󰐥 Shutdown"
  "󰑥 Reboot"
  "󰤄 Suspend"
  "󰍃 Logout"
)

# Show menu and get selection
selected=$(printf '%s\n' "${options[@]}" |
  fuzzel --dmenu --width=12 --lines=5 --prompt="Power: ")

# Execute based on selection
case "$selected" in
  "󰐥 Shutdown")
    systemctl poweroff
    ;;
  "󰑥 Reboot")
    systemctl reboot
    ;;
  "󰤄 Suspend")
    systemctl suspend
    ;;
  "󰍃 Logout")
    niri msg action quit
    ;;
  "󰌾 Lock")
    swaylock
    ;;
  *)
    exit 0
    ;;
esac

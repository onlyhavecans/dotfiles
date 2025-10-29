#!/usr/bin/env bash
# Fuzzel-based window selector for niri
# Jump to any window by selecting its title

set -euo pipefail

# Get list of windows from niri
windows=$(niri msg --json windows)

# Check if we got any windows
if [ -z "$windows" ] || [ "$windows" = "[]" ]; then
  notify-send "Window Selector" "No windows found" -u normal
  exit 0
fi

# Parse windows into format: "id|app_id|title"
window_data=$(echo "$windows" | jq -r '.[] | "\(.id)|\(.app_id // "unknown")|\(.title // "Untitled")"')

# Create display list: "app_id: title" (truncate long titles)
display_list=$(echo "$window_data" | awk -F'|' '{
    title = $3
    if (length(title) > 80) {
        title = substr(title, 1, 77) "..."
    }
    printf "%s | %s\n", $2, title
}')

# Show in fuzzel
selected=$(echo "$display_list" | fuzzel --dmenu --prompt="Window: " --width=40)

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Find the window ID corresponding to the selection
line_num=$(echo "$display_list" | grep -n -F "$selected" | cut -d: -f1 | head -n1)
window_id=$(echo "$window_data" | sed -n "${line_num}p" | cut -d'|' -f1)

# Focus the window using niri
if [ -n "$window_id" ]; then
  niri msg action focus-window --id "$window_id"
fi

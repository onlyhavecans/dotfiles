#!/bin/sh
grim -g "$(slurp)" - |
  satty --filename - \
    --output-filename "$HOME/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"

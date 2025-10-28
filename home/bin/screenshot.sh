#!/bin/sh
grim -g "$(slurp)" - |
  satty --filename - \
    --save-after-copy \
    --font-family Noto \
    --output-filename "$HOME/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"

#!/bin/sh

# Credit to the following for comming up with this:
# https://code.krister.ee/lock-screen-in-sway/
# To Do: The fancier screen lock mentioned on that page might be cool to try.

# Times the screen off and puts it to background
swayidle \
  timeout 5 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' &

# Locks the screen immediately
swaylock

# Kills last background task so idle timer doesn't keep running
kill %%

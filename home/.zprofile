# if [ $(uname) = "Linux" ]; then
#   if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
#     exec sway
#   fi
#
#   export ELECTRON_OZONE_PLATFORM_HINT=wayland
# fi

# Added by OrbStack: command-line tools and integration
[[ -f ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh 2>/dev/null || :

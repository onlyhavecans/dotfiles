## I only zprofile on linux rn
if [ $(uname) = "Linux" ]; then
  if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec sway
  fi

  export ELECTRON_OZONE_PLATFORM_HINT=wayland
fi

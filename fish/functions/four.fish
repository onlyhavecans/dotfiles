function four --description "Update all my frebsd stuff that isn't pinned"
  # set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  vim +PluginUpdate +qall
  sudo freebsd-update fetch
  sudo pkg update
  sudo pkg clean
  sudo pkg autoremove
  sudo pkg upgrade
end

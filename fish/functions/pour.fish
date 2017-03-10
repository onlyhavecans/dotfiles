function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the cheef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade
  ## This is because of chef-dk always making broken synlinks
  brew prune
  brew doctor
  vim +PlugUpgrade +qall
  vim +PlugUpdate
end

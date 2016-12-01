function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the cheef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade
  ## Only clean up older than 60 days because neovim jmalloc issue screwed me
  brew cleanup --prune=60
  ## This is because of chef-dk always making broken synlinks
  brew prune
  brew doctor
  vim +PlugUpgrade +qall
  vim +PlugUpdate
end

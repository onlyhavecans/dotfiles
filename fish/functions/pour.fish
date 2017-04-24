function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the cheef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade
  status_message brew prune since chef-dk always makes broken synlinks
  brew prune
  status_message pregenerate fuck command to save shell launch time
  if test -x /usr/local/bin/thefuck
    thefuck --alias | source
    funcsave fuck
  end
  status_message doctor brew
  brew doctor
  vim +PlugUpgrade +qall
  vim +PlugUpdate
end

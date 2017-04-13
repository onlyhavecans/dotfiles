function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the cheef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade
  ## This is because of chef-dk always making broken synlinks
  brew prune
  # pregenerate fuck command to save shell launch time
  if test -x /usr/local/bin/thefuck
    thefuck --alias | source
    funcsave fuck
  end
  # pregenerate chef-dk to save shell launch timeo
  if test -x /opt/chefdk/bin/chef
    /opt/chefdk/bin/chef shell-init fish > {$HOME}/.chefdk.fish
  end
  brew doctor
  vim +PlugUpgrade +qall
  vim +PlugUpdate
end

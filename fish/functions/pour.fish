function pour --description "Update all my homebrew stuff that isn't pinned"
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade --cleanup
  brew cleanup -s
  ## This is because of chef-dk always making broken synlinks
  brew prune
  brew doctor
  nvim -c "Dein update"
end

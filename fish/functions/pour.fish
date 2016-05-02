function pour --description "Update all my homebrew stuff that isn't pinned"
  set -l PATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin
  brew update
  brew upgrade --cleanup --all
  brew cleanup -s
end

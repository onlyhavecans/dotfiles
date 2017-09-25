function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the chef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin $HOME/.cargo/bin
  brew update
  brew upgrade
  status_message brew prune since chef-dk always makes broken synlinks
  brew prune
  status_message pregenerate fuck command to save shell launch time
  if test -x /usr/local/bin/thefuck
    thefuck --alias | source
    funcsave fuck
  end
  status_message Rust it up
  rustup update
  status_message doctor brew
  brew doctor
  brew missing
  if test -x /usr/local/bin/mas
    mas outdated
  end
  vim +PlugUpgrade +qall
  vim +PlugUpdate
end

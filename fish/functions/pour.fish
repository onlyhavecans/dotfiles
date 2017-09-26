function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the chef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin $HOME/.cargo/bin
  brew update
  brew upgrade

  status_message brew prune since chef-dk always makes broken synlinks
  brew prune

  if test -x /usr/local/bin/thefuck
    status_message pregenerate fuck command to save shell launch time
    thefuck --alias | source
    funcsave fuck
  end

  if test -x $HOME/.cargo/bin/rustup
    status_message Rust it up
    rustup update
  end

  status_message update all the vim stuff
  vim +PlugUpgrade +qall
  vim +PlugUpdate +qall

  if test -x $HOME/.tmux/plugins/tpm/bin/update_plugins
    status_message update tmux plugins
    ~/.tmux/plugins/tpm/bin/update_plugins all
  end

  status_message doctor brew
  brew doctor
  status_message Check for missing packages
  brew missing

  if test -x /usr/local/bin/mas
    status_message do I have any outdated App Store apps
    mas outdated
  end
end

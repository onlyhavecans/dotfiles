function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the chef-dk stuff
  set -lx PATH $HOME/.cargo/bin /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin

  status_message Update castles
  homeshick pull
  homeshick link

  status_message Update my brew packages
  brew update
  brew upgrade

  if test -x /usr/local/bin/thefuck
    status_message Pregenerate fuck command to save shell launch time
    thefuck --alias | source
    funcsave fuck
  end

  if test -x $HOME/.cargo/bin/rustup
    status_message Rust update
    rustup update
  end

  status_message Clean up vim-plug repos to prevent errors
  for plugin in ~/.config/nvim/plugged/*
    git -C $plugin reset --quiet --hard HEAD
  end
  status_message Update vim-plug
  nvim +PlugUpgrade +qall
  status_message Update all the vim-plug plugins
  nvim +PlugUpdate +qall
  nvim +UpdateRemotePlugins +qall

  if test -x $HOME/.tmux/plugins/tpm/bin/update_plugins
    status_message Update and clean tmux plugins
    ~/.tmux/plugins/tpm/bin/install_plugins
    ~/.tmux/plugins/tpm/bin/update_plugins all
    ~/.tmux/plugins/tpm/bin/clean_plugins
  end

  status_message Check for missing packages
  brew missing

  status_message do I have any outdated App Store apps
  mas outdated
end

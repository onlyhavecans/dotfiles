function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the chef-dk stuff
  set -lx PATH $HOME/.pyenv/shims $HOME/.cargo/bin /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade

  status_message brew prune since chef-dk always makes broken synlinks
  brew cleanup

  if test -x /usr/local/bin/thefuck
    status_message Pregenerate fuck command to save shell launch time
    thefuck --alias | source
    funcsave fuck
  end

  if test -x $HOME/.cargo/bin/rustup
    status_message Rust update
    rustup update
  end

  status_message Set up and update neovim python
  status_message Set up python 2 neovim
  if not test -x $HOME/.pyenv/versions/neovim2
    pyenv virtualenv 2.7.15 neovim2
  end

  set -lx PYENV_VERSION neovim2
  pip install --quiet --quiet --upgrade pip
  pip install --quiet --upgrade 'python-language-server[all]' autopep8 rope flake8 pylint pytest
  pip install --quiet --quiet --upgrade --force neovim
  set -le PYENV_VERSION

  status_message Set up python 3 neovim
  if not test -x $HOME/.pyenv/versions/neovim3
    pyenv virtualenv 3.7.1 neovim3
  end
  set -lx PYENV_VERSION neovim3
  pip install --quiet --quiet --upgrade pip
  pip install --quiet --upgrade 'python-language-server[all]' autopep8 rope flake8 pylint pytest
  pip install --quiet --quiet --upgrade --force neovim
  set -le PYENV_VERSION

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

  if test -x /usr/local/bin/mas
    status_message do I have any outdated App Store apps
    mas outdated
  end
end

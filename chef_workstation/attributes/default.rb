#
# Author:: tBunnyMan
# Cookbook Name:: attributes
# Attributes:: default
#
# Copyright 2014-2016, D.O.S.

default['workstation']['user'] = nil
default['workstation']['dotfiles_dir'] = 'dotfiles'
default['workstation']['secrets_dir'] = 'secrets'

##
# How to set up my dotfiles
default['workstation']['dot_dirs'] = %w( .config .config/nvim .vagrant.d )
default['workstation']['links'] = {
  'direnvrc'    => '.direnvrc',
  'fish'        => '.config/fish',
  'gitconfig'   => '.gitconfig',
  'gitignore'   => '.gitignore_global',
  'kitchen'     => '.kitchen',
  'polipo'      => '.polipo',
  'pylintrc'    => '.pylintrc',
  'rubocop.yml' => '.rubocop.yml',
  'tmux.conf'   => '.tmux.conf',
  'Vagrantfile' => '.vagrant.d/Vagrantfile',
  'vim'         => '.vim',
  'vim/gvimrc'  => '.gvimrc',
  'vim/vimrc'   => '.vimrc',
}

##
# Generic packages to install
default['workstation']['packages']['generic'] = %w(
  openssl
  bind
  clamav
  curl
  direnv
  elixir
  exa
  exercism
  fish
  git
  git-lfs
  git-standup
  gnupg
  go
  heroku
  httpie
  hub
  jq
  libsodium
  mobile-shell
  nmap
  polipo
  ponysay
  privoxy
  pyenv
  pyenv-virtualenv
  python
  python3
  ripgrep
  ruby
  ruby-install
  rustup-init
  shellcheck
  sshuttle
  thefuck
  tmux
  tree
)

default['workstation']['packages']['freebsd'] = %w(
  feather
  keybase
  neovim
  tarsnap
)

default['workstation']['packages']['mac_os_x'] = %w(
  awscli
  mas
  pinentry-mac
  reattach-to-user-namespace
  watch
  youtube-dl
)

# Casked applications
default['homebrew']['casks'] = %w(
  vagrant
)

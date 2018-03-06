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
  'direnvrc'      => '.direnvrc',
  'fish'          => '.config/fish',
  'git/gitconfig' => '.gitconfig',
  'git/gitignore' => '.gitignore_global',
  'kitchen'       => '.kitchen',
  'polipo'        => '.polipo',
  'pylintrc'      => '.pylintrc',
  'rubocop.yml'   => '.rubocop.yml',
  'tmux.conf'     => '.tmux.conf',
  'Vagrantfile'   => '.vagrant.d/Vagrantfile',
  'vim'           => '.config/nvim'
}

##
# Generic packages to install
default['workstation']['packages']['generic'] = %w(
  openssl
  bind
  clamav
  cowsay
  curl
  direnv
  elixir
  exa
  exercism
  fish
  fortune
  gist
  git
  git-lfs
  git-standup
  gnupg
  go
  heroku
  hugo
  httpie
  hub
  jq
  libsodium
  mobile-shell
  neovim
  nmap
  polipo
  privoxy
  pyenv
  pyenv-virtualenv
  python
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
  tarsnap
  python3
)

default['workstation']['packages']['mac_os_x'] = %w(
  awscli
  mas
  pinentry-mac
  reattach-to-user-namespace
  watch
  whois
  youtube-dl
)

# Casked applications
default['homebrew']['casks'] = %w(
  vagrant
)

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
  clamav
  ctags
  curl
  elixir
  fish
  git
  git-lfs
  go
  gnupg
  hub
  mobile-shell
  nmap
  polipo
  ponysay
  privoxy
  python
  python3
  sshuttle
  the_silver_searcher
  thefuck
  tmux
  tree
)

default['workstation']['packages']['freebsd'] = %w(
  bsdinfo
  feather
  keybase
  neovim
  tarsnap
)

default['workstation']['packages']['mac_os_x'] = %w(
  archey
  reattach-to-user-namespace
  watch
  youtube-dl
)

# Casked applications
default['workstation']['caskapps'] = %w(
  vagrant
)

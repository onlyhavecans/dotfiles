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
  'pylintrc'    => '.pylintrc',
  'rubocop.yml' => '.rubocop.yml',
  'tmux.conf'   => '.tmux.conf',
  'Vagrantfile' => '.vagrant.d/Vagrantfile',
  'vim'         => '.config/nvim/init.vim',
  'vim'         => '.vim',
  'vim/gvimrc'  => '.gvimrc',
  'vim/vimrc'   => '.vimrc',
}

##
# Generic packages to install
default['workstation']['packages'] = %w(
  openssl
  archey
  clamav
  dsh
  elixir
  exiftool
  fish
  git
  gnupg2
  hub
  keybase
  nmap
  node
  polipo
  postgresql
  python
  python3
  the_silver_searcher
  tmux
  tree
  vim
  watch
  yara
  youtube-dl
)

## old casked apps
# a-better-finder-rename
# adobe-creative-cloud
# alfred
# anki
# atom
# bartender
# bittorrent-sync
# busycontacts
# coda
# dropbox
# evernote
# google-chrome
# iterm2
# kaledoscope
# keyboard-maestro
# openemu
# screenhero
# steam
# transmit
# vitamin-r

# Casked applications
default['workstation']['caskapps'] = %w(
  vagrant
)
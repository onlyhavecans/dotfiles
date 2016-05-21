#
# Author:: tBunnyMan
# Cookbook Name:: attributes
# Attributes:: default
#
# Copyright 2014-2015, tBunnyMan

default['workstation']['user'] = nil
default['workstation']['dotfiles_dir'] = 'dotfiles'
default['workstation']['vundle_remote'] = 'https://github.com/VundleVim/Vundle.vim.git'

##
# How to set up my dotfiles
default['workstation']['links'] = {
  'fish'        => '.config/fish',
  'gitconfig'   => '.gitconfig',
  'gitignore'   => '.gitignore_global',
  'gpg.conf'    => '.gnupg/gpg.conf',
  'kitchen'     => '.kitchen',
  'pylintrc'    => '.pylintrc',
  'rubocop.yml' => '.rubocop.yml',
  'tmux.conf'   => '.tmux.conf',
  'vim'         => '.vim',
  'vim/gvimrc'  => '.gvimrc',
  'vim/vimrc'   => '.vimrc',
}

##
# Generic packages to install
default['workstation']['packages'] = %w(
  archey
  clamav
  dsh
  exiftool
  fish
  git
  gnupg2
  hub
  keybase
  nmap
  polipo
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

#
# Author:: tBunnyMan
# Cookbook Name:: attributes
# Attributes:: default
#
# Copyright 2014-2015, tBunnyMan

default['workstation']['user'] = nil
default['workstation']['dotfiles_dir'] = 'dotfiles'
default['workstation']['vundle_remote'] = "https://github.com/gmarik/Vundle.vim.git"

##
# How to set up my dotfiles
default['workstation']['links'] = {
  "fish"       => ".config/fish",
  "gitconfig"  => ".gitconfig",
  "gitignore"  => ".gitignore_global",
  "i3wm"       => ".i3",
  "pylintrc"   => ".pylintrc",
  "tmux.conf"  => ".tmux.conf",
  "vim"        => ".vim",
  "vim/gvimrc" => ".gvimrc",
  "vim/vimrc"  => ".vimrc",
}

##
# Generic packages to install
default['workstation']['packages'] = [
  'ctags',
  'git',
  'fish',
  'dsh',
  'gnupg2',
  'tmux',
  'tree',
  'nmap',
  'python',
  'python3',
  'youtube-dl',
  'yara',
]

##
# Mac Specific packages (homebrew)
default['homebrew']['formulas'] = [
  'archey',
  'irssi',
]

##
# Mac Casks to install
default['homebrew']['casks'] = [
  # The package installers
  'vagrant',
  'virtualbox',
  'crashplan',
# The dropins
  'alfred',
  'anki',
  'arduino',
  'atom',
  'bartender',
  'bittorrent-sync',
  'caffeine',
  'coda',
  'dropbox',
  'evernote',
  'fastscripts',
  'firefox',
  'flash-player',
  'fluid',
  'flux',
  'google-chrome',
  'hex-fiend',
  'iterm2',
  'kaleidoscope',
  'knox',
  'macvim',
  'marked',
  'moom',
  'mplayerx',
  'mysqlworkbench',
  'omnifocus',
  'omnioutliner',
  'panic-unison',
  'skype',
  'skitch',
  'spillo',
  'superduper',
  'the-unarchiver',
  'transmit',
  'viscosity',
  'vlc',
  'wineskin-winery',
]

##
# How to set up my dotfiles
default[:dotfiles] = {
  :user   => node[:current_user],
  :dir    => File.join(Dir.home(node[:current_user]), "dotfiles"),
  :remote => "git@stash.bunni.biz:7999/cfg/dotfiles.git",
  :links  => {
    "vim"	 => ".vim",
    "vim/vimrc"  => ".vimrc",
    "vim/gvimrc" => ".gvimrc",
    "fish"       => ".config/fish",
  }
}

##
# The old way
default[:links][:oldstyle] = [
  'git',
  'i3wm',
  'python',
  'tmux',
]

##
# Vundle locations for vim
default[:vundle] = {
  :pdir   => File.join(node[:dotfiles][:dir], "vim", "bundle"),
  :vdir   => File.join(node[:dotfiles][:dir], "vim", "bundle", "Vundle.vim"),
  :remote => "git@github.com:gmarik/Vundle.vim.git"
}

##
# Generic packages to install
default[:workstation][:packages] = [
  'vim',
  'git',
  'fish',
  'dsh',
  'gnupg2',
  'tmux',
  'tree',
  'nmap',
  'python',
  'python3',
]

##
# Mac Specific packages (homebrew)
default[:homebrew][:formula] = [
  'archey',
  'irssi',
]

##
# Mac Casks to install
default[:homebrew][:casks] = [
  'alfred',
  'anki',
  'bartender',
  'caffeine',
  'ccmenu',
  'dropbox',
  'evernote',
  'fastscripts',
  'firefox',
  'flash-player',
  'flux',
  'google-chrome',
  'hex-fiend',
  'hipchat',
  'hoppergdbserver',
  'hopper-disassembler',
  'iterm2',
  'kaleidoscope',
  'knox',
  'macvim',
  'moom',
  'mysqlworkbench',
  'omnifocus',
  'phpstorm',
  'pycharm',
  'postgres',
  'send-to-kindle',
  'skype',
  'skitch',
  'sourcetree',
  'spotify',
  'superduper',
  'textexpander',
  'the-unarchiver',
  'transmit',
  'vagrant',
  'virtualbox',
  'viscosity',
  'wineskin-winery',
]

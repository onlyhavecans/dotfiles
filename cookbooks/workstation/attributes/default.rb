
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

default[:vundle] = {
  :pdir   => File.join(node[:dotfiles][:dir], "vim", "bundle"),
  :vdir   => File.join(node[:dotfiles][:dir], "vim", "bundle", "Vundle.vim"),
  :remote => "git@github.com:gmarik/Vundle.vim.git"
}

# The old way
default[:links][:oldstyle] = [
  'git', 'i3wm', 'python', 'tmux'
]

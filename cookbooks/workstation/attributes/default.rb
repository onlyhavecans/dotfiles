
default[:dotfiles] = {
  :user   => node[:current_user],
  :dir    => File.join(Dir.home(node[:current_user]), "dotfiles"),
  :remote => "git@github.com:tbunnyman/dotfiles.git",
  :links  => {
    "vim/vim.symlink"   => ".vim",
    "vim/vimrc.symlink" => ".vimrc",
    "fish" => ".config/fish",
  }
}

default[:vundle] = {
  :pdir   => File.join(node[:dotfiles][:dir], "vim", "vim.symlink", "bundle"),
  :vdir   => File.join(node[:dotfiles][:dir], "vim", "vim.symlink", "bundle", "Vundle.vim"),
  :remote => "git@github.com:gmarik/Vundle.vim.git"
}

# The old way
default[:links][:oldstyle] = [
  'git', 'i3wm', 'python', 'tmux'
]

node[:links][:oldstyle].each do |dir|
  linkglob = File.join(node[:dotfiles][:dir], dir, "*.symlink")
  Dir.glob(linkglob).each do |linkfile|
    basefile = File.basename(linkfile)[0..-9]
    dest = File.join(Dir.home(node[:dotfiles][:user]), ".#{basefile}")
    link dest do
      to linkfile
    end
  end
end

node[:dotfiles][:links].each do |key, value|
  original = File.join(node[:dotfiles][:dir], key)
  dotted = File.join(Dir.home(node[:dotfiles][:user]), value)

  # Chef can't overwrite folders with symlinks so destroy it if we find one.
  # This is mostly for fish & vim
  if !File.symlink?(dotted) && File.directory?(dotted)
    directory dotted do
      action :delete
      recursive true
    end
  end

  link dotted do
    to original
  end
end


##
# ensure Vundle
##
package 'git'
package 'vim'

directory node[:vundle][:pdir] do
  owner node[:dotfiles][:user]
  recursive true
end

git node[:vundle][:vdir] do
  repository node[:vundle][:remote]
  revision "master"
  user node[:dotfiles][:user]
  action :checkout
end

bash 'initalize_vundle' do
  code 'vim +PluginInstall +qall'
end

#
# Cookbook Name:: workstation
# Recipe:: dotfiles
#
# Copyright (C) 2014-2015
#
Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

##
# Old dirty way
node['links']['oldstyle'].each do |dir|
  linkglob = File.join(workstation_user_home, node['workstation']['dotfiles_dir'], dir, "*.symlink")
  Dir.glob(linkglob).each do |linkfile|
    basefile = File.basename(linkfile)[0..-9]
    dest = File.join(workstation_user_home, ".#{basefile}")

    link dest do
      to linkfile
      user workstation_user
    end
  end
end

##
# Proper dotfile links
node['workstation']['links'].each do |key, value|
  original = File.join(workstation_user_home, node['workstation']['dotfiles_dir'], key)
  dotted = File.join(workstation_user_home, value)

  # Chef can't overwrite folders with symlinks so destroy it if we find one.
  # This is mostly for fish & vim
  directory dotted do
    action :delete
    recursive true
    only_if { !File.symlink?(dotted) && File.directory?(dotted) }
  end

  link dotted do
    to original
    user workstation_user
  end
end


##
# ensure Vundle
##
package 'git'

vundle_dir = File.join(workstation_user_home, "vim", "bundle", "Vundle.vim")

directory vundle_dir do
  owner workstation_user
  recursive true
end

git vundle_dir do
  repository node['workstation']['vundle_remote']
  revision "master"
  user workstation_user
  action :checkout
end

bash 'initalize_vundle' do
  code 'vim +PluginInstall +qall'
  user workstation_user
end

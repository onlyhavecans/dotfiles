#
# Cookbook Name:: workstation
# Recipe:: default
#
# Copyright (C) 2014-2015
#
Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

Chef::Log.info("Workstation user is #{workstation_user}")
Chef::Log.info("Workstation user's home path is #{workstation_user_home}")

##
# Install all my OS specific goodies
case node['platform']
  when 'debian', 'ubuntu'
    include_recipe 'workstation::ubuntu'
  when 'mac_os_x'
    include_recipe 'workstation::mac'
end

##
# Install global packages
node['workstation']['packages'].each do |my_package|
  package my_package
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
# Setup Vundle
package 'git'

vundle_dir = File.join(workstation_user_home, ".vim", "bundle", "Vundle.vim")

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


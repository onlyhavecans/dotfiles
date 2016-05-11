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
# All the following requires this, so lets only set this once
%w( /usr/local /usr/local/bin /usr/local/etc ).each do |local_dir|
  directory local_dir do
    user      workstation_user
    group     'staff'
    recursive true
  end
end

##
# Set up askpass first for any upcoming sudos or questions
include_recipe 'workstation::ssh_askpass'

include_recipe 'homebrew'

##
# Install global packages
package node['workstation']['packages'] do
  action :install
end

bash 'brew_cleanup' do
  code 'brew cleanup -s'
  user workstation_user
end

##
# My gnupg config requires a specific cert for my keyserver
remote_file '/usr/local/etc/openssl/certs/hkps.pool.sks-keyservers.net.pem' do
  source   'https://sks-keyservers.net/sks-keyservers.netCA.pem'
  checksum '0666ee848e03a48f3ea7bb008dbe9d63dfde280af82fb4412a04bf4e24cab36b'
  mode     '0644'
end
#
##
# Proper dotfile links
directory File.join(workstation_user_home, '.config') do
  user   workstation_user
  group  workstation_user
  action :create
end

node['workstation']['links'].each do |key, value|
  original = File.join(workstation_user_home, node['workstation']['dotfiles_dir'], key)
  dotted = File.join(workstation_user_home, value)

  # Chef can't overwrite folders with symlinks so destroy it if we find one.
  # This is mostly for fish & vim
  directory dotted do
    recursive true
    action    :delete
    only_if { !File.symlink?(dotted) && File.directory?(dotted) }
  end

  link dotted do
    to   original
    user workstation_user
  end
end


##
# Setup Vundle
package 'git'

bundle_dir = File.join(workstation_user_home, '.vim', 'bundle')
vundle_dir = File.join(bundle_dir, 'Vundle.vim')

%w(bundle_dir vundle_dir).each do |vim_dirs|
  directory vim_dirs do
    owner  workstation_user
    group  workstation_user
    action :create
  end
end

git vundle_dir do
  repository node['workstation']['vundle_remote']
  revision   'master'
  user       workstation_user
  action     :checkout
end

bash 'initalize_vundle' do
  code 'vim +PluginInstall +qall'
  user workstation_user
end


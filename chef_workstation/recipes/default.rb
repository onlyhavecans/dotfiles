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
%w( /usr/local/bin /usr/local/etc ).each do |local_dir|
  directory local_dir do
    user      workstation_user
    group     'admin'
    recursive true
    action    :create
    not_if { ::File.exist?(local_dir) }
  end
end

##
# Set up askpass first for any upcoming sudos or questions
include_recipe 'workstation::ssh_askpass'

include_recipe 'homebrew'

##
# Install global packages
node['workstation']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

##
# My gnupg config requires a specific cert for my keyserver
remote_file '/usr/local/etc/openssl/certs/hkps.pool.sks-keyservers.net.pem' do
  source   'https://sks-keyservers.net/sks-keyservers.netCA.pem'
  checksum '0666ee848e03a48f3ea7bb008dbe9d63dfde280af82fb4412a04bf4e24cab36b'
  mode     '0644'
end

##
# Proper dotfile links
include_recipe "workstation::dotfiles"

##
# Checkout Vundle
bundle_dir = ::File.join(workstation_user_home, '.vim', 'bundle')
directory bundle_dir do
  owner     workstation_user
  recursive true
  action    :create
end

vundle_dir = ::File.join(bundle_dir, 'Vundle.vim')
workstation_checkout vundle_dir do
  repo_url 'https://github.com/VundleVim/Vundle.vim.git'
end

tmuxplugins_dir = ::File.join(workstation_user_home, '.tmux', 'plugins')
directory tmuxplugins_dir do
  owner     workstation_user
  recursive true
  action    :create
end

tpm_dir = ::File.join(tmuxplugins_dir, 'tpm')
workstation_checkout tpm_dir do
  repo_url 'https://github.com/tmux-plugins/tpm'
end

# Build Vundle
bash 'build_vundle' do
  code '/usr/local/bin/vim +VundleInstall +qall'
  user workstation_user
end

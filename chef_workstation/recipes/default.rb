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

case node['platform']
when 'mac_os_x'
  include_recipe 'chef_workstation::mac'
when 'freebsd'
  include_recipe 'chef_workstation::freebsd'
end

##
# Install global packages
node['workstation']['packages']['generic'].each do |pkg|
  package pkg do
    action :install
  end
end

os_pkgs = node['workstation']['packages'][node['platform']]
if os_pkgs
  os_pkgs.each do |pkg|
    package pkg do
      action :install
    end
  end
else
  Chef::Log.error('OS packages do not exist for your OS!')
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
include_recipe "workstation::secrets"

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

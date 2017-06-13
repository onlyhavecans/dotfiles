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
  include_recipe 'workstation::mac'
when 'freebsd'
  include_recipe 'workstation::freebsd'
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
directory '/usr/local/etc/openssl' do
  action :create
end
directory '/usr/local/etc/openssl/certs' do
  action :create
end

remote_file '/usr/local/etc/openssl/certs/hkps.pool.sks-keyservers.net.pem' do
  source   'https://sks-keyservers.net/sks-keyservers.netCA.pem'
  checksum '0666ee848e03a48f3ea7bb008dbe9d63dfde280af82fb4412a04bf4e24cab36b'
  mode     '0644'
end

##
# Proper dotfile links
include_recipe 'workstation::secrets'

##
# Proper dotfile links
include_recipe 'workstation::dotfiles'

##
# Set mah shell
user workstation_user do
  shell '/usr/local/bin/fish'
  action :manage
end

#
# Cookbook Name:: workstation
# Recipe:: mac
#
# Copyright (C) 2014-2015
#
Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

##
# ssh-askpass is a good thing
directory "/usr/local/bin" do
  recursive true
  user workstation_user
end

cookbook_file "/usr/local/bin/ssh-askpass" do
  source "ssh-askpass"
  user workstation_user
  mode "0755"
end

ENV['SUDO_ASKPASS'] = '/usr/local/bin/ssh-askpass'

##
# Initalizing Homebrew
# I'm using attributes for all of this
include_recipe 'homebrew'
include_recipe 'homebrew::install_formulas'
include_recipe 'homebrew::install_casks'

##
# Cask is messy so clean up after it
bash 'brew_cleanup' do
  code 'brew cask cleanup'
  user workstation_user
end

##
# My gnupg config requires a specific cert for my keyserver
remote_file '/usr/local/etc/openssl/certs/hkps.pool.sks-keyservers.net.pem' do
  source   'https://sks-keyservers.net/sks-keyservers.netCA.pem'
  checksum '0666ee848e03a48f3ea7bb008dbe9d63dfde280af82fb4412a04bf4e24cab36b'
  mode     0644
end

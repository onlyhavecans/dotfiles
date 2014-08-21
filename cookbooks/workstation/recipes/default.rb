#
# Cookbook Name:: workstation
# Recipe:: default
#
# Copyright (C) 2014
#
#

##
# Install all my OS specific goodies
case node[:platform]
  when 'debian', 'ubuntu'
    include_recipe 'workstation::ubuntu'
  when 'mac_os_x'
    include_recipe 'workstation::mac'
end

##
# Install global packages
node[:workstation][:packages].each do |my_package|
  package my_package
end

##
# Dotfile linkup!
include_recipe 'workstation::dotfiles'


#
# Cookbook Name:: workstation
# Recipe:: vundle
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

powerline_dir = ::File.join(dofiles_directory, 'powerline')

directory powerline_dir do
  owner  workstation_user
  action :create
end

bash 'Initial_powerline_clone' do
  code "git clone #{node['workstation']['powerline_remote']}"
  cwd  powerline_dir
  user workstation_user
  not_if { ::File.exist?(powerline_dir) }
end

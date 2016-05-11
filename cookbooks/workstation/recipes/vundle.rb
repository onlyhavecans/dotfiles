#
# Cookbook Name:: workstation
# Recipe:: vundle
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

bundle_dir = ::File.join(workstation_user_home, '.vim', 'bundle')
vundle_dir = ::File.join(bundle_dir, 'Vundle.vim')

directory bundle_dir do
  owner  workstation_user
  action :create
end

bash 'Initial_vundle_clone' do
  code "git clone #{node['workstation']['vundle_remote']}"
  cwd  bundle_dir
  user workstation_user
  not_if { ::File.exist?(vundle_dir) }
end

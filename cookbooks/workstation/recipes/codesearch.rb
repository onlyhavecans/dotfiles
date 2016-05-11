#
# Cookbook Name:: workstation
# Recipe:: codesearch
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'go' do
  action :install
end

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

apps_dir = ::File.join(workstation_user_home, 'Applications')

directory apps_dir do
  user   workstation_user
  action :create
  not_if { ::File.exist?(apps_dir) }
end

bash 'install_codesearch' do
  cwd Chef::Config['file_cache_path']
  code <<-EOL
  env GOPATH="#{Chef::Config['file_cache_path']}" go get #{node['workstation']['codesearch']['path']}
  cp #{Chef::Config['file_cache_path']}/bin/* #{apps_dir}/
  EOL
  not_if { ::File.exist?("#{apps_dir}/csearch") }
end

#
# Cookbook Name:: workstation
# Recipe:: dotfiles
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

node['workstation']['dot_dirs'].each do |dot_dirs|
  directory ::File.join(workstation_user_home, dot_dirs) do
    user   workstation_user
    action :create
  end
end

node['workstation']['links'].each do |key, value|
  original = ::File.join(dofiles_directory, key)
  dotted = ::File.join(workstation_user_home, value)

  workstation_dotfile dotted do
    source original
    my_user workstation_user
  end
end

#
# Cookbook Name:: workstation
# Recipe:: dotfiles
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

directory ::File.join(workstation_user_home, '.config') do
  user   workstation_user
  action :create
end

node['workstation']['links'].each do |key, value|
  original = ::File.join(workstation_user_home, node['workstation']['dotfiles_dir'], key)
  dotted = ::File.join(workstation_user_home, value)

  # Chef can't overwrite folders with symlinks so destroy it if we find one.
  # This is mostly for fish & vim
  directory dotted do
    recursive true
    action    :delete
    only_if { !::File.symlink?(dotted) && File.directory?(dotted) }
  end

  link dotted do
    to   original
    user workstation_user
  end
end

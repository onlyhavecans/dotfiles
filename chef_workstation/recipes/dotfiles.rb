#
# Cookbook Name:: workstation
# Recipe:: dotfiles
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

unless ::File.directory?(dotfiles_directory)
  Chef::Log.fatal("You do not have a dotfiles directory!")
  return
end

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
#execute 'build_vundle' do
#  command '/usr/local/bin/vim +VundleInstall +qall'
#  user workstation_user
# end

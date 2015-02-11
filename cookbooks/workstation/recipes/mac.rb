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

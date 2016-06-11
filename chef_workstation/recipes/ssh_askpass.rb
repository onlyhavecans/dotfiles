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
cookbook_file '/usr/local/bin/ssh-askpass' do
  source 'ssh-askpass'
  user   workstation_user
  mode   '0755'
end

ENV['SUDO_ASKPASS'] = '/usr/local/bin/ssh-askpass'
ENV['SSH_ASKPASS'] = '/usr/local/bin/ssh-askpass'

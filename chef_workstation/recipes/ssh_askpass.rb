#
# Cookbook Name:: workstation
# Recipe:: mac
#
# Copyright (C) 2014-2015
#
Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

homebrew_tap 'homebrew/dupes'
homebrew_package 'ssh-askpass'

ENV['SUDO_ASKPASS'] = '/usr/local/bin/ssh-askpass'
ENV['SSH_ASKPASS'] = '/usr/local/bin/ssh-askpass'

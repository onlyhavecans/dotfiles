#
# Cookbook Name:: chef_workstation
# Recipe:: mac
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

##
# All the following requires this, so lets only set this once
%w( /usr/local/bin /usr/local/etc ).each do |local_dir|
  directory local_dir do
    user      workstation_user
    group     'admin'
    recursive true
    action    :create
    not_if { ::File.exist?(local_dir) }
  end
end

##
# Set up askpass first for any upcoming sudos or questions
include_recipe 'workstation::ssh_askpass'

include_recipe 'homebrew::default'
include_recipe 'homebrew::install_casks'

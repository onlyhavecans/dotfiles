#
# Cookbook Name:: workstation
# Recipe:: default
#
# Copyright (C) 2014 
#
# 


include_recipe 'workstation::dotfiles'

# Run the prereq for the OS
case node[:platform]
when 'debian', 'ubuntu'
  include_recipe 'workstation::ubuntu'
when 'mac_os_x'
  include_recipe 'workstation::mac'
end

# Install more global packages
package "tmux"
package "tree"
package "vim"
package "nmap"

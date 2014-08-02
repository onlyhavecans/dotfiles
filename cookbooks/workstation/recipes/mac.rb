#
# Cookbook Name:: workstation
# Recipe:: mac
#
# Copyright (C) 2014 
# 

# Initalizing Homebrew
# directory '/usr/local' do
#   owner node[:current_user]
#   group node[:root_group]
#   mode "0775"
# end

include_recipe 'homebrew'
include_recipe "homebrew::cask"


package "fish"
package "dsh"
package "gnupg2"
package "archey"
package "irssi"
package "macvim"
package "python"
package "python3"

homebrew_cask 'google-chrome'


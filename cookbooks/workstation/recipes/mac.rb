#
# Cookbook Name:: workstation
# Recipe:: mac
#
# Copyright (C) 2014 
# 

##
# Initalizing Homebrew
# I'm using attributes for all of this
include_recipe 'homebrew'
include_recipe 'homebrew::install_formulas'
include_recipe 'homebrew::install_casks'

##
# Cask is messy so clean up after it
bash 'brew_alfred_link' do
  code 'brew cask alfred link'
end

bash 'brew_cleanup' do
  code 'brew cask cleanup'
end

#
# Cookbook Name:: chef_workstation
# Recipe:: secrets
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

Chef::Resource.send(:include, Workstation::Mixin)
Chef::Recipe.send(:include, Workstation::Mixin)

unless ::File.directory?(secrets_directory)
  Chef::Log.fatal("You do not have a secrets directory!")
end

secrets_glob = ::File.join(secrets_directory, "*")
secrets = ::Dir.glob(secrets_glob)

secrets.each do |secret|
  original = secret
  dotted = ::File.join(workstation_user_home, "." + ::File.basename(secret))

  workstation_dotfile dotted do
    source original
    my_user workstation_user
  end
end

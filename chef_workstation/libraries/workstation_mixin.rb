#
# Author:: tBunnyMan
# Cookbook Name:: workstation
# Libraries:: workstation_mixin
#
# Copyright 2015 tBunnyman
#

module Workstation
  module Mixin
    def workstation_user
      @workstation_user ||= calculate_user
    end

    def workstation_user_home
      @workstation_user_home ||= calculate_home
    end

    def dotfiles_directory
      @dofiles_directory ||= calculate_dotfiles_directory
    end

    def secrets_directory
      @secrets_directory ||= calculate_secrets_directory
    end

    private

    def calculate_user
      owner = workstation_user_attribute || sudo_user || 'dos'
      owner = 'dos' if owner == 'root'
      owner
    end

    def workstation_user_attribute
      node['workstation']['user']
    end

    def sudo_user
      ENV['SUDO_USER']
    end

    def calculate_home
      File.join(Dir.home(workstation_user))
    end

    def calculate_dotfiles_directory
      File.join(workstation_user_home, node['workstation']['dotfiles_dir'])
    end

    def calculate_secrets_directory
      File.join(workstation_user_home, node['workstation']['secrets_dir'])
    end

  end
end


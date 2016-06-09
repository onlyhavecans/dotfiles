# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 sts=2 et :
##
# I kitchen a lot while traveling so I need something very agressive in caching.
#  These two plugins may seem reduntant but they give amazing coverage
#
# If you copy paste install this understand it has a minimum version requirement
#  and also will FORCE INSTALL plugins. You may not want that. I do.

Vagrant.require_version ">= 1.8"
VAGRANTFILE_API_VERSION = "2"
required_plugins = %w(vagrant-vbguest vagrant-cachier vagrant-proxyconf)
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## My plugins are not optional, they are manditory
  if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system("vagrant plugin install #{plugins_to_install.join(' ')}")
      exit system('vagrant', *ARGV)
    else
      abort "Installation of one or more plugins has failed. Aborting."
    end
  end

  # https://github.com/dotless-de/vagrant-vbguest
  if Vagrant.has_plugin?("vagrant-vbguest")
    # Because freebsd
    config.vbguest.auto_update = false
  end

  # https://github.com/tmatilai/vagrant-proxyconf
  if Vagrant.has_plugin?("vagrant-proxyconf")
    # config.proxy.http     = "http://127.0.0.1:8123/"
    # config.proxy.https    = "http://127.0.0.1:8123/"
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end

  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # scope needs to be machine if you are going to be using concurrency in kitchen
    #  ie on CI workers
    config.cache.scope = :box
    config.cache.auto_detect = true
    config.cache.enable :apt
    config.cache.enable :chef
    config.cache.enable :chef_gem
    config.cache.enable :gem
  end
end

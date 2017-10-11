# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 sts=2 et :
##
# I kitchen a lot while traveling so I need something very agressive in caching.
#  These two plugins may seem reduntant but they give amazing coverage

Vagrant.require_version ">= 1.8"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # https://github.com/dotless-de/vagrant-vbguest
  if Vagrant.has_plugin?("vagrant-vbguest")
    # Because freebsd I don't like autoupdating
    config.vbguest.auto_update = false
  end

  # https://github.com/tmatilai/vagrant-proxyconf
  if Vagrant.has_plugin?("vagrant-proxyconf")
    ## You may need to change these IPs depending on the network of the guest OS
    # Most VMs in kithens use 10.0.2 but 192.168.0 also exists
    # this can be any IP on your machine from my testing
    config.proxy.http     = "http://192.168.55.1:8123/"
    config.proxy.https    = "http://192.168.55.1:8123/"
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end

  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # scope needs to be machine if you are going to be using concurrency in kitchen
    config.cache.scope = :box
    config.cache.auto_detect = true
    # config.cache.synced_folder_opts = {
    #   type: :nfs,
    #   # The nolock option can be useful for an NFSv3 client that wants to avoid the
    #   # NLM sideband protocol. Without this option, apt-get might hang if it tries
    #   # to lock files needed for /var/cache/* operations. All of this can be avoided
    #   # by using NFSv4 everywhere. Please note that the tcp option is not the default.
    #   mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    # }
    # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  end
end

function vgsync --description 'Syncs the sd-vagrant-dev cookbook with vagrant-dev-vm'
    cd ~/Code/sd-chef/cookbooks/sd-vagrant-dev
    berks install
    berks update
    berks package ~/Code/vagrant-dev-vm/sd-vagrant-dev.tar
    cd ~/Code/vagrant-dev-vm/
    rm -rf cookbooks
    tar -xvf sd-vagrant-dev.tar
    rm sd-vagrant-dev.tar
end

function vgsync --description 'Syncs the sd-vagrant-dev cookbook with vagrant-dev-vm'
    cd ~/Code/vagrant-dev-vm/sd-vagrant-dev
    berks install
    berks update
    berks vendor ../cookbooks
end

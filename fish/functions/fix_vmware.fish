function fix_vmware --description "Clean up after broken AF vagrant-vmware plugin"
  # From https://github.com/hashicorp/vagrant/issues/9624

  status_message "Clean up bad add_nat_port_fwd's from networking config"
  # Delete 'add_nat_portfwd 8 tcp 2201 192.168.107.170 22 '
  # But not 'add_nat_portfwd 8 tcp 2222 192.168.107.171 22 vagrant: /users/dos/code/dnsimple/ops/cookbooks/postgres/.kitchen/kitchen-vagrant/default-ubuntu-1604/.vagrant/machines/default/vmware_fusion/58786f2b-a9ff-4bba-bedc-5412d0263613/ubuntu-16.04-amd64.vmx'
  sudo sed  -i .bak '/^add_nat_port_fwd 8 tcp \d+ \w+ 22 $/d' /Library/Preferences/VMware\ fusion/networking
 
  status_message "Clean up incoming mappings in nat.conf"
  # 2201 = 192.168.107.170:22
  sudo sed -i .bak '/^22\d\d = \w+:22$/d' /Library/Preferences/VMware\ fusion/vmnet8/nat.conf

  status_message "Re-init vmnet after touching configs"
  sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --configure
  sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --stop
  sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --start

  status_message Vagrant is Hopefully fixed!
end

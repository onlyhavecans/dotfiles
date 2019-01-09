function update_chefdk --description "Update chef-dk & refresh gems"
  if test 1 -eq (count $argv)
    set -l version "-v $argv"
  else
    set -l version ""
  end

  set -l old_directory (pwd)
  cd ~/Code/dnsimple/ops

  eval (chef shell-init fish)
  curl https://www.chef.io/chef/install.sh | sudo bash -s -- -P chef-workstaton

  rm -rf ~/.chefdk
  chef exec bundle install

  cd $old_directory
end

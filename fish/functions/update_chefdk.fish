function update_chefdk --description "Update chef-dk & refresh gems"
  if test 1 -eq (count $argv)
    set -l version "-v $argv"
  else
    set -l version ""
  end

  set -l old_directory (pwd)
  cd ~/Code/dnsimple/ops

  eval (chef shell-init fish)
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk

  rm -rf ~/.chefdk
  chef exec bundle install

  cd $old_directory
end

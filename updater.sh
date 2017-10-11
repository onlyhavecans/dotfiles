#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR" || exit 10

echo "Do a pull just to be sure we are up to date"
git pull origin master || exit 5

if [[ ! -d /opt/chefdk ]]; then
  echo "You haven't instaled Chef-DK!!! I don't do this automatically anymore"
  echo 'curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -P chefdk'
fi

## Find berks or die
if [[ -x /opt/chefdk/bin/berks ]]; then
  BERKS="/opt/chefdk/bin/berks"
elif [[ -x /usr/local/bin/berks ]]; then
  BERKS="/usr/local/bin/berks"
elif [[ $(which berks) ]]; then
  BERKS=$(which berks)
else
  echo "Can't find berks... chef-dk needs to be installed"
  exit 42
fi

## Vendor the cookbook to always have reqs
cd "$DIR/chef_workstation" || exit 10
$BERKS install
$BERKS update
$BERKS vendor "$DIR/cookbooks"
cd "$DIR" || exit 10

CLIENT=$(which chef-client)
if [[ ! -f $CLIENT && -f /opt/chefdk/bin/chef-client ]]; then
  CLIENT=/opt/chefdk/bin/chef-client
fi

echo "Run chef, NEEDS SUDO"
sudo rm -rf local-mode-cache
sudo $CLIENT -z --runlist 'recipe[workstation]'

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Awesome! You'll probably want to 'pour/four' and './rust-init.sh' "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

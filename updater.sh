#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

echo "Do a pull just to be sure we are up to date"
git pull origin master || exit 5

if [[ ! -d /opt/chefdk ]]; then
echo "curlbash chef like I hate security b/c you didn't install chef-dk"
  curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -P chefdk
fi

## Vendor the cookbook to always have reqs
cd $DIR/chef_workstation
BERKS="/opt/chefdk/bin/berks"
$BERKS install
$BERKS update
mkdir $DIR/cookbooks
$BERKS vendor $DIR/cookbooks
cd $DIR

CLIENT=$(which chef-client)
if [[ ! -f $CLIENT && -f /opt/chefdk/bin/chef-client ]]; then
  CLIENT=/opt/chefdk/bin/chef-client
fi

echo "Run chef, NEEDS SUDO"
sudo $CLIENT -z --runlist 'recipe[workstation]'

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Awesome! don't forget to manually install your tmux plugins with ^aI"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

echo "Do a pull just to be sure we are up to date"
git pull origin master || exit 5

if [[ ! -d /opt/chefdk ]]; then
  echo "You haven't instaled Chef-DK!!! I don't do this automatically anymore"
  echo 'curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -P chefdk'
  echo " "
  echo "!! If it's not here it's gonna die. Enter to continue or ^C to quit"
  read do_i_care
fi

## Find berks or die
if [[ -z /opt/chefdk/bin/berks ]]; then
  BERKS="/opt/chefdk/bin/berks"
elif [[ -z /usr/local/bin/berks ]]; then
  BERKS="/usr/local/bin/berks"
elif [[ $(which berks) ]]; then
  BERKS=$(which berks)
else
  echo "Can't find berks... chef-dk needs to be installed"
  exit 42
fi

## Vendor the cookbook to always have reqs
cd $DIR/chef_workstation
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
echo " and also /usr/local/bin/vim +VundleInstall +qall for vim"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

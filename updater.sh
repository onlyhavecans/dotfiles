#!/usr/bin/env bash
echo "Do a pull just to be sure we are up to date"
git pull origin master || exit 5

echo "Check for chef"
if  [[ ! -d /opt/chefdk ]]; then
  curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -P chefdk
fi

echo "Update/Download homebrew cookbook"
curl -#L https://supermarket.getchef.com/cookbooks/homebrew/download | tar -zxf - -C cookbooks/

CLIENT=$(which chef-client)
if [[ ! -f $CLIENT && -f /opt/chefdk/bin/chef-client ]]; then
  CLIENT=/opt/chefdk/bin/chef-client
fi

echo "ensure homebrew permissions with a sudo"
echo "(also a trick to make chef tasks that need sudo work"
sudo chown -R `whoami`:staff /usr/local

echo "Run chef"
$CLIENT -z --runlist 'recipe[workstation]'

#!/usr/bin/env bash

echo "Check for chef"
if  [[ ! -d /opt/chef && ! -d /opt/chefdk ]]; then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

echo "Update/Download homebrew cookbook"
curl -#L https://supermarket.getchef.com/cookbooks/homebrew/download | tar -zxf - -C cookbooks/

CLIENT=$(which chef-client)
if [[ -f /opt/chefdk/bin/chef-client ]]; then 
  CLIENT=/opt/chefdk/bin/chef-client
elif [[ -f /opt/chef/bin/chef-client ]]; then
  CLIENT=/opt/chef/bin/chef-client
fi

echo "Do a pull just to be sure we are up to date"
git pull origin master || exit 5

echo "ensure homebrew permissions with a sudo"
echo "(also a trick to make chef tasks that need sudo work"
sudo chown -R `whoami`:staff /usr/local

echo "Run chef"
$CLIENT -z --runlist 'recipe[workstation]'

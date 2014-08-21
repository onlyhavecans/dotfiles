#!/usr/bin/env bash

if  [[ ! -d /opt/chef && ! -d /opt/chefdk ]]; then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

curl -#L https://supermarket.getchef.com/cookbooks/homebrew/download | tar -zxf - -C cookbooks/

CLIENT=$(which chef-client)
if [[ -f /opt/chefdk/bin/chef-client ]]; then 
  CLIENT=/opt/chefdk/bin/chef-client
elif [[ -f /opt/chef/bin/chef-client ]]; then
  CLIENT=/opt/chef/bin/chef-client
fi


git pull origin master || exit 5

##
# ensure homebrew (also a trick to make chef tasks that need sudo work"
sudo chown -R `whoami`:staff /usr/local

# Most of the work
$CLIENT -z --runlist 'recipe[workstation]'

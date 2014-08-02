#!/usr/bin/env bash -x

if  [[ ! -d /opt/chef && ! -d /opt/chefdk ]]; then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi
if [[ ! -d /opt/chefdk ]]; then
  echo " !!!!!!!!!!!!!!!!! "
  echo " !!!!!!!!!!!!!!!!! "
  echo " You should install Chef-dk at http://downloads.getchef.com/chef-dk "
fi

CLIENT=$(which chef-client)
if [[ -f /opt/chefdk/bin/chef-client ]]; then 
  CLIENT=/opt/chefdk/bin/chef-client
elif [[ -f /opt/chef/bin/chef-client ]]; then
  CLIENT=/opt/chef/bin/chef-client
fi


git add -p
git commit
put push || exit 5

$CLIENT -z --runlist 'recipe[homebrew],recipe[workstation]'

#!/usr/bin/env bash -x

if  [[ ! -d /opt/chef && ! -d /opt/chefdk ]]; then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi
if [[ ! -d /opt/chefdk ]]; then
  echo " !!!!!!!!!!!!!!!!! "
  echo " !!!!!!!!!!!!!!!!! "
  echo " You should install Chef-dk at http://downloads.getchef.com/chef-dk "
fi
if [[ ! -d cookbooks/homebrew ]]; then
  curl -L https://supermarket.getchef.com/cookbooks/homebrew/download | tar -zxf - -C cookbooks/
fi

CLIENT=$(which chef-client)
if [[ -f /opt/chefdk/bin/chef-client ]]; then 
  CLIENT=/opt/chefdk/bin/chef-client
elif [[ -f /opt/chef/bin/chef-client ]]; then
  CLIENT=/opt/chef/bin/chef-client
fi


git add -p
git commit
git push || exit 5

echo -n "Press enter to chef, kill to walk away"
read reply

# Most of the work
$CLIENT -z --runlist 'recipe[homebrew],recipe[workstation]'

# Update plugins
vim +PluginInstall +qall
vim +PluginUpdate +qall
vim +PluginClean +qall

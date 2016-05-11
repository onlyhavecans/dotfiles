#!/usr/bin/env bash
echo "Do a pull just to be sure we are up to date"
git pull origin master || exit 5

echo "curlbash chef like I hate security"
curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -P chefdk

echo "Update/Download homebrew cookbook"
curl -#L https://supermarket.getchef.com/cookbooks/homebrew/download | tar -zxf - -C cookbooks/
echo "Update/Download build-essential cookbook"
curl -#L https://supermarket.getchef.com/cookbooks/build-essential/download | tar -zxf - -C cookbooks/

CLIENT=$(which chef-client)
if [[ ! -f $CLIENT && -f /opt/chefdk/bin/chef-client ]]; then
  CLIENT=/opt/chefdk/bin/chef-client
fi

echo "Run chef, NEEDS SUDO"
sudo $CLIENT -z --runlist 'recipe[workstation]'
sudo rm -rf local-mode-cache

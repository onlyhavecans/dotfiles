function dnpull --description "pull all my cookbooks up up"
  set -l dnpath ~/Code/dnsimple-ops/cookbooks
  for i in *
    status_message gitpull $i
    cd $dnpath/$i
    git checkout master -q
    git pull
    status_message finished $i
  end
  cd $dnpath
end

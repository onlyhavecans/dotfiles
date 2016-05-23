function dnpull --description "pull all my cookbooks up up"
  set -l dnpath ~/Code/dnsimple-ops/cookbooks
  cd $dnpath
  for i in *
    status_message gitpull $i
    cd $dnpath/$i
    git pull
  end
  cd $dnpath
end

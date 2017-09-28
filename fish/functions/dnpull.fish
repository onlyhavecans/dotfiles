function dnpull --description "pull all my cookbooks up up"
  set -l dnpaths ~/Code/dnsimple ~/Code/dnsimple/ops/cookbooks
  for dir in $dnpaths
    cd $dir
    for i in *
      status_message gitpull $i
      cd $dir/$i
      git checkout master -q
      git pull
      status_message finished $i
    end
  end
  cd $dnpaths[1]
end

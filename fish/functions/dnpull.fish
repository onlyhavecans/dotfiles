function dnpull --description "pull all my cookbooks up up"
  set -l dnpaths ~/Code/dnsimple ~/Code/dnsimple/ops/cookbooks ~/go/src/github.com/dnsimple
  for dir in $dnpaths
    cd $dir
    for i in *
      if test -d "$dir/$i/.git"
        status_message gitpull $i
        cd $dir/$i
        git checkout master -q
        git pull
        status_message finished $i
      else
        status_message skipping $i
      end
    end
  end
  cd $dnpaths[1]
end

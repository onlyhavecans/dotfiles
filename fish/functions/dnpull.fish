function dnpull --description "pull all my cookbooks up up"
  set -l dnpaths ~/Code/dnsimple ~/Code/dnsimple/ops/cookbooks ~/go/src/github.com/dnsimple
  for dir in $dnpaths
    cd $dir
    for i in *
      if test -d "$dir/$i/.git"
        status_message Jumping into $i
        cd $dir/$i

        git fetch
        git diff-index --quiet HEAD --
        if test $status != 0
          status_message $i is dirty so skipping!!!
          continue
        end

        git checkout master -q
        git pull
        status_message finished $i
      end
    end
  end
  cd $dnpaths[1]
end

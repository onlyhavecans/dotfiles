function dnpull --description "pull all my cookbooks up up"
  set -l dnpaths ~/Code ~/go/src/github.com/dnsimple
  for top_dir in $dnpaths
    for dir in (find $top_dir -name .git -type d -print)
      cd $dir/..
      set -l local_dir (pwd)

      if test -z "(git remote)"
        status_message $local_dir does not have a remote so skipping
        continue
      end

      echo ""
      status_message Updating $local_dir
      git fetch --quiet

      git checkout master --quiet
      if test $status != 0
        continue
      end
      git pull
    end
  end
  cd ~
end

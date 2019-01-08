function dnpull --description "pull all my cookbooks up up"
  set -l my_directory
  for dir in (fd --hidden --no-ignore --fixed-strings .git --type d --exclude .direnv --exclude gocode --exclude .github $my_directory)
    cd $dir/..
    set -l local_dir (pwd)

    if test (git remote | wc -l) -eq 0
      status_message $local_dir does not have a remote so skipping
      continue
    end

    status_message Updating $local_dir
    git fetch --quiet

    git checkout master --quiet
    if test $status != 0
      continue
    end
    git pull
    git_cleanup
  end
  cd $my_directory
end

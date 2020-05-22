function dnpull --description "pull all my cookbooks up up"
  for dir in (fd --hidden --no-ignore --fixed-strings .git --type d --exclude .direnv --exclude gocode --exclude .github $my_directory)
    set -l local_dir (realpath $dir/..)
    set -l my_git git -C $local_dir

    if test ($my_git remote | wc -l) -eq 0
      status_message $local_dir does not have a remote so skipping
      continue
    end

    status_message Updating $local_dir
    $my_git fetch --quiet

    # $my_git checkout master --quiet
    # if test $status != 0
    #   continue
    # end
    $my_git pull
  end
end

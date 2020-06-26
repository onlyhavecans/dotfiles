function fix_git_local_clone --description "Fix master usage in git"
  git checkout master
  git branch -m master main
  git fetch -p
  git branch --unset-upstream
  git branch -u origin/main
  git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
end

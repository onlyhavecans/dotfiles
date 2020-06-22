function fix_git_branches --description "Fix master usage in git"
  git switch master
  git pull -p
  git branch -m master main
  git push -u origin main

  user_prompt "Please Update Default branch in Github/Gitea before continuing"
  git push orgin --delete master
end

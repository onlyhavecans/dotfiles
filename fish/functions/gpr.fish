function gpr --description "Push (to my fork if present) and open PR"
  set -l my_fork "onlyhavecans"
  if git remote | grep --silent $my_fork
    status_message "Personal fork present, pushing to $my_fork"
    git push $my_fork
  else
    status_message "no fork present, pushing to origin"
    git push origin
  end

  git pull-request --browse
end

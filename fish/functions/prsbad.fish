function prsbad --description "Push (to my fork if present) and open PR while reminding me PR'S BAD"
  set -l my_github_user "onlyhavecans"

  if git rev-parse --abbrev-ref HEAD | grep --silent master
    status_message "!!! You are on master!"
    status_message "No pushing to master!"
    return 1
  end

  if git remote | grep --silent $my_github_user
    status_message "Personal fork present, pushing to $my_github_user"
    git push $my_github_user
  else
    status_message "no fork present, pushing to origin"
    git push origin
  end

  hub pull-request --assign=$my_github_user --push --browse
end

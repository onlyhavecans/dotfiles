function prsbad --description "Push (to my fork if present) and open PR while reminding me PR'S BAD"
  set -l my_github_user "onlyhavecans"
  set -l audio_file (random choice (find ~/ResilioSync/Documents/PR-GNUS -iname \*mp3))

  afplay $audio_file &

  if git remote | grep --silent $my_github_user
    status_message "Personal fork present, pushing to $my_github_user"
    git push $my_github_user
  else
    status_message "no fork present, pushing to origin"
    git push origin
  end

  hub pull-request --assign=$my_github_user --push --browse
end

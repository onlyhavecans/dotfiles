function git_cleanup
  for branch in (git branch -vv | awk '/ gone/ {print $1}')
    # if user_prompt "Remove deleted branch $branch?"
      git branch -D $branch
    # end
  end
end

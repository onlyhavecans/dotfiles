function subl-review --description "open all changed files in subl"
  if git show-ref --verify --quiet refs/heads/main
    set branch main
  else
    set branch master
  end
  echo branch is $branch

  git diff --name-only $branch...HEAD | xargs subl
end

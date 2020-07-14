function tag_rel --description "Git tag a release"
  if not test 1 -eq (count $argv)
    status_message "Please pass the git version only"
    return 1
  end

  set -l ver $ver $argv[1]

  git tag --annotate $ver --sign --message="Release $ver"
  git push origin $ver
end

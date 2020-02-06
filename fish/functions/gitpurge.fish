function gitpurge
  status_message "This deletes all but current and master branches. gitclean is cleaner"
  for branch in (git branch -vv | awk '{ if( !( $1 == "master" || $1 == "*" ) ) print $1}')
    git branch -D $branch
  end
end

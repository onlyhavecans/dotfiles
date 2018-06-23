# Stole from https://github.com/martinisoft/dotfiles/blob/master/home/.config/fish/functions/git_cleanup.fish
function git_cleanup
  hub sync
  for branch in (git branch -vv | grep ' gone' | cut -d' ' -f1-3 | sed -e 's/^[[:space:]]*//')
      git branch -D $branch
  end
end

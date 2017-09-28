function setgithooks --description 'set up githooks'
  set -l hooks_dir $HOME/dotfiles/git/hooks
  set -l lang $argv[1]

  if not test -d $hooks_dir/$lang
    status_message "😖  You don't have any hooks for $lang!!"
    return -1
  end

  if not test -d .git
    status_message "Only run this from the root of a git directory!"
    return -1
  end

  git config core.hooksPath $hooks_dir/$lang
  status_message "Hooks all set up!"
end

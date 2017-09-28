## I like being strict with my path in shells
if status is-interactive
  set -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin
  set -Ue fish_user_paths

  set -l prepend_dirs $HOME/bin $HOME/Applications
  for dir in $prepend_dirs
    test -d $dir; and set -x PATH $dir $PATH
  end

  set -l append_dirs $HOME/.fzf/bin /opt/X11/bin
  for dir in $append_dirs
    test -d $dir; and set -x PATH $PATH $dir
  end
end

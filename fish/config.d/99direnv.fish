if test -x /usr/local/bin/direnv
  direnv hook fish | source
  alias tmux "direnv exec / tmux"
end

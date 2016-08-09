function tssh --description "Set term for tmux ssh sessions"
  set -lx TERM xterm-256color
  ssh $argv
end

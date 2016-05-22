function root --description "Log into work boxes"
  set -lx TERM xterm-256color
  ssh -YAl dos $argv
end

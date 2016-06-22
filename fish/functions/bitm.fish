function bitm --description "Log into old boxes"
  set -lx TERM xterm-256color
  ssh -YAl bitm $argv
end

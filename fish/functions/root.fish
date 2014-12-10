function root --description "Log into work boxes"
  set TERM xterm-256color
  ssh -YA $argv
end

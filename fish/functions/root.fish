function root --description "Loginto a box as root"
  set TERM xterm-256color
  ssh -YA -l root $argv
end

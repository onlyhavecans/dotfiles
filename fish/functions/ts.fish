function ts --description "Log into my shell & throw up tmux"
  if test 0 -ne (count $argv)
    status_message "That's not what this is for anymore"
  else
    set -lx TERM xterm-256color
    mosh colo01.squirrels.wtf -- tmux attach
  end
end

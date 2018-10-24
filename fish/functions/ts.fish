function ts --description "Log into my shell & throw up tmux"
  if test 0 -ne (count $argv)
    status_message "That's not what this is for anymore"
  else
    set -lx TERM xterm-256color
    ssh -t colo01.squirrels.wtf "tmux attach; or tmux new"
  end
end

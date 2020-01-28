function work --description "Set up my standard workspace"
  if not test -z "$TMUX_PANE"
    echo "Oh no! You are already in TMUX"
  else
    if not tmux has-session -t work
      tmux new-session -d -s work
      tmux split-window -h -p 30 -t work
      # tmux send-keys -t work:1.2 'irssi' C-m
      tmux split-window -v -p 66 -t work
      # tmux split-window -v -l 25 -t work
      tmux select-pane -t work:1.1
      tmux split-window -v -l 15 -t work:1.1
      tmux split-window -v -l 8 -t work:1.1
      tmux select-pane -t work:1.1
    end
    exec tmux attach -d -t work
  end
end


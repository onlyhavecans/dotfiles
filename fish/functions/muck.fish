function muck --description "Activate my muck window"
  if not test -z "$TMUX_PANE"
    echo "Oh no! You are already in TMUX"
  else
    cd ~/muck
    if not tmux has-session -t muck
      tmux new-session -d -c ~/muck -n chat -s muck
      tmux split-window -v -t muck
      tmux send-keys -t muck:1.2 'tail -F */out' C-m
      tmux resize-pane -y 2 -t muck:1.1
      tmux split-window -v -l 6 -t muck 'vim mucking_around'
      tmux new-window -d -n past 'vim'
      tmux split-window -h -t muck:1.1
      tmux select-pane -t muck:1.1
    end
    exec tmux attach -d -t muck
  end
end

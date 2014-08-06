function work
  if not test -z "$TMUX"
    echo "Oh no! You are already in TMUX"
  else
    if not tmux has-session -t work
      tmux new-session -d -s work
      #If you call vim directly instead of launching it it breaks tmux/vim
      tmux send-keys -t work:1.1 'vim +NERDTree' C-m
      tmux split-window -h -p 30 -t work 'irssi'
      tmux split-window -v -t work
      tmux split-window -v -t work
      tmux select-pane -t work:1.1
      tmux split-window -v -l 15 -t work:1.1
      tmux split-window -v -l 8 -t work:1.1
      tmux select-pane -t work:1.1
    end
    exec tmux attach -d -t work
  end
end


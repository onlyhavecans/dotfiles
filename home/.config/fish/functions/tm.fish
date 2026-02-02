function tm --description "Tmux session manager - attach or create predefined sessions"
    # If already in tmux, switch sessions
    if test -n "$TMUX"
        tmux choose-tree -s
        return
    end

    # If any session exists, attach
    if tmux has-session 2>/dev/null
        tmux attach-session
        return
    end

    # First time: create all sessions
    # This prevents direnv bugs
    cd ~ || exit 2

    # Session 0: Demo
    tmux new-session -d -s Demo -n Main -c ~/Code
    tmux new-window -t Demo -n Tests -c ~/Code
    tmux new-window -t Demo -n Live -c ~/Code
    tmux select-window -t Demo:Main

    # Session 1: InsideOut
    tmux new-session -d -s InsideOut -n nix -c ~/Code/nixos-skwrls
    tmux new-window -t InsideOut -n dots -c ~/.homesick/repos/dotfiles
    tmux split-window -v -t dots -c ~/.homesick/repos/neovim
    tmux new-window -t InsideOut -n blog -c ~/Code/websites/squirrels.wtf
    tmux split-window -v -l 10 -t blog -c ~/Code/websites/squirrels.wtf
    tmux select-window -t InsideOut:nix

    # Session 2: WorkWork
    tmux new-session -d -s WorkWork -n Project -c ~/Code/dnsimple
    tmux new-window -t WorkWork -n Incident -c ~/Downloads
    tmux new-window -t WorkWork -n Reviews -c ~/Code/dnsimple
    tmux select-window -t WorkWork:Project

    # Session 3: Dream
    tmux new-session -d -s Dream -n 🐰 -c ~/Sync/muck
    tmux new-window -t Dream -n 🐴 -c ~/Sync/muck
    tmux new-window -t Dream -n 🕷 -c ~/Sync/muck
    tmux select-window -t Dream:🐰

    # Attach to InsideOut
    tmux attach-session -t InsideOut
end

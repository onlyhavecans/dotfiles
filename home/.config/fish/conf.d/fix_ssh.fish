# Keep SSH_AUTH_SOCK in tmux panes in sync with the last attached client
status is-interactive; or return
set -q TMUX; or return

function __fix_ssh_preexec --on-event fish_preexec
    fix_ssh -q
end

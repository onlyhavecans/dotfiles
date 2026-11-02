# Refresh SSH_AUTH_SOCK in a tmux pane from the session env of the last attach.
# Use -q to suppress warnings.
function fix_ssh --description 'Refresh SSH_AUTH_SOCK from tmux'
    argparse q/quiet -- $argv; or return 2
    set -l warn true
    set -q _flag_quiet; and set warn false

    if not set -q TMUX
        $warn; and echo "fix_ssh: not in tmux" >&2
        return 1
    end

    set -l line (tmux show-environment SSH_AUTH_SOCK 2>&1)
    or begin
        $warn; and echo "fix_ssh: tmux: $line (is SSH_AUTH_SOCK in update-environment?)" >&2
        return 1
    end

    if string match -q -- '-*' $line
        $warn; and echo "fix_ssh: last attached client had no SSH_AUTH_SOCK (agent forwarding off?)" >&2
        return 1
    end

    set -l sock (string replace -- 'SSH_AUTH_SOCK=' '' $line)
    if not test -S "$sock"
        $warn; and echo "fix_ssh: $sock is not a socket (ssh session gone?)" >&2
        return 1
    end

    test "$SSH_AUTH_SOCK" = "$sock"; and return 0
    set -gx SSH_AUTH_SOCK $sock
    $warn; and echo "fix_ssh: SSH_AUTH_SOCK=$sock"
    return 0
end

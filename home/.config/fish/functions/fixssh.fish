function fixssh --description 'Update SSH_AUTH_SOCK from parent window to fix SSH keys'
    set -x SSH_AUTH_SOCK (tmux showenv | grep "SSH_AUTH_SOCK" | sed -e "s@SSH_AUTH_SOCK=@@")
end

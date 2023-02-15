# Prevent duplicate path because they annoy me
typeset -U path

## Putting paths even in non-interactive shells makes Apps Happy™
[ -x /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)
[ -x /usr/local/bin/brew ]    && eval $(/usr/local/bin/brew shellenv)
[ -d "$HOME/.cargo/bin" ]     && path=("$HOME/.cargo/bin" $path)
[ -d "$HOME/go/bin" ]         && path=("$HOME/go/bin" $path)
[ -d "$HOME/bin" ]            && path=("$HOME/bin" $path)
[ -d "$HOME/go" ]             && export GOPATH=$HOME/go

# Mosh Server settings are needed at init
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
export MOSH_SERVER_SIGNAL_TMOUT=60
# Clean up any session that has not been connected to in 30 days
export MOSH_SERVER_NETWORK_TMOUT=2592000

# Putting this in non-interactive makes Apps use 1Password
# The setting is exported instead of in ssh/config so I can have the test and fallback if this isn't set up
[ -S "$HOME/.1password/agent.sock" ] && export SSH_AUTH_SOCK=$HOME/.1password/agent.sock

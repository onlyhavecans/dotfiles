# Prevent duplicate path because they annoy me
typeset -U path

## Putting paths even in non-interactive shells makes Apps Happy™
# Set up all of homebrew if present, or just localbin
if [ -x /opt/homebrew/bin/brew ]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
elif [ -x /usr/local/bin/brew ]; then
    export HOMEBREW_PREFIX="/usr/local";
    export HOMEBREW_CELLAR="/usr/local/Cellar";
    export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
    export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/usr/local/share/info:${INFOPATH:-}";
    path=(/usr/local/bin /usr/local/sbin $path)
elif [ -d /usr/local/bin ];then
    path=(/usr/local/bin /usr/local/sbin $path)
fi

# basic dev paths
[ -d "$HOME/.cargo/bin" ] && path=("$HOME/.cargo/bin" $path)
[ -d "$HOME/go/bin" ]     && path=("$HOME/go/bin" $path)
[ -d "$HOME/bin" ]        && path=("$HOME/bin" $path)
[ -d "$HOME/go" ]         && export GOPATH=$HOME/go


# Mosh Server settings are needed at init
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
export MOSH_SERVER_SIGNAL_TMOUT=60
# Clean up any session that has not been connected to in 30 days
export MOSH_SERVER_NETWORK_TMOUT=2592000

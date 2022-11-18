# Prevent duplicate path because they annoy me
typeset -U path

# Give everything path, even without interactive
if [ -x /opt/homebrew/bin/brew ]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
else
    path=(/usr/local/bin /usr/local/sbin $path)
fi

[ -d "$HOME/.cargo/bin" ] && path=("$HOME/.cargo/bin" $path)
[ -d "$HOME/go/bin" ]     && path=("$HOME/go/bin" $path)
[ -d "$HOME/bin" ]        && path=("$HOME/bin" $path)

# Mosh Server settings are needed at init
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
export MOSH_SERVER_SIGNAL_TMOUT=60
# Clean up any session that has not been connected to in 30 days
export MOSH_SERVER_NETWORK_TMOUT=2592000

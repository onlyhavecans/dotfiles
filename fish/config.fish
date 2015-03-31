if status --is-interactive
  set PATH /opt/chefdk/bin /opt/chefdk/embedded/bin $HOME/.chefdk/gem/ruby/2.1.0/bin
  set PATH $PATH $HOME/Applications /usr/local/bin /usr/local/sbin
  set PATH $PATH /usr/bin /bin /usr/sbin /sbin
  /usr/local/bin/archey --color
end

if test -z "$TMUX"
  set TERM screen-256color
end

set -x EDITOR vim

# Chef DK (possibly fragile, damn)
set -x GEM_ROOT /opt/chefdk/embedded/lib/ruby/gems/2.1.0
set -x GEM_HOME $HOME/.chefdk/gem/ruby/2.1.0
set -x GEM_PATH $HOME/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0

# Powerline love
set -x POWERLINE_ROOT $HOME/dotfiles/vim/bundle/powerline
set -x POWERLINE_COMMAND $POWERLINE_ROOT/scripts/powerline-render
set -x POWERLINE_CONFIG_COMMAND $POWERLINE_ROOT/scripts/powerline-config
eval $POWERLINE_ROOT/scripts/powerline-daemon -q

set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

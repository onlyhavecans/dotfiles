if status --is-interactive
  set PATH /opt/chefdk/bin /opt/chefdk/embedded/bin $HOME/.chefdk/gem/ruby/2.1.0/bin /usr/local/bin /usr/local/sbin $PATH;
  /usr/local/bin/archey --color
end

if test -z "$TMUX"
  set TERM screen-256color
end

set -x EDITOR vim

set -x POWERLINE_ROOT $HOME/dotfiles/vim/bundle/powerline/
set -x POWERLINE_COMMAND $POWERLINE_ROOT/scripts/powerline-render
set -x POWERLINE_CONFIG_COMMAND $POWERLINE_ROOT/scripts/powerline-config
eval $POWERLINE_ROOT/scripts/powerline-daemon -q
# -p $HOME/dotfiles/powerline

set fish_function_path $fish_function_path "$POWERLINE_ROOT/powerline/bindings/fish"
powerline-setup

set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

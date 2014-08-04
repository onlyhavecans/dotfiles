if status --is-interactive
  set PATH /opt/chefdk/bin /opt/chefdk/embedded/bin $HOME/.chefdk/gem/ruby/2.1.0/bin /usr/local/sbin /usr/local/bin $PATH;
  /usr/local/bin/archey --color
end

set EDITOR vim
set -x PAGER vimpager
set -x GIT_PAGER less


set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

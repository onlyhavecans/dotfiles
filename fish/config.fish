if status --is-interactive
  set PATH /usr/bin /bin /usr/sbin /sbin

  ## 2016-05-19
  # Currently chef-dk is being a dick so interject it here and then set the rest of my path
  # Chef DK (No longer fragile as of chef-dk 0.5.0)
  if test -x /opt/chefdk/bin/chef; or test -x (which chef)
    eval (/opt/chefdk/bin/chef shell-init fish)
  end

  set PATH $HOME/Applications /usr/local/bin /usr/local/sbin $PATH
  /usr/local/bin/archey --color
end

if test -z "$TMUX"
  set TERM screen-256color
end

set -x EDITOR vim

## I use vmware
set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion

# Powerline love
set -x POWERLINE_ROOT $HOME/dotfiles/vim/bundle/powerline
set -x POWERLINE_COMMAND $POWERLINE_ROOT/scripts/powerline-render
set -x POWERLINE_CONFIG_COMMAND $POWERLINE_ROOT/scripts/powerline-config
eval $POWERLINE_ROOT/scripts/powerline-daemon -q

set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

# Abbreviations
abbr --add nerd vim +NERDTree
abbr --add vundle vim +PluginUpdate +qall
abbr --add flushdns sudo killall -HUP mDNSResponder
## Mo Git Mo Problems
abbr --add gad git add --all
abbr --add gap git add --patch
abbr --add gc git commit
abbr --add gp git push
abbr --add gpb 'git push; and berkit'
abbr --add gpu git pull
abbr --add gst git status
abbr --add gitclean 'git branch --merged master | grep -v " master" | grep -v "\*" | xargs -n 1 git branch -d'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

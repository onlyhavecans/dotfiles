if status --is-interactive
  set PATH /usr/bin /bin /usr/sbin /sbin
  set PATH $HOME/Applications /usr/local/bin /usr/local/sbin $PATH
  if test -x /opt/chefdk/bin/chef; or test -x (which chef)
    eval (/opt/chefdk/bin/chef shell-init fish)
  end

  /usr/local/bin/archey --color
end

if test -z "$TMUX"
  set TERM screen-256color
end

set -x EDITOR vim

## I'm using hub
if test -x /usr/local/bin/hub
  eval (hub alias -s)
end

## I use vmware
#set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion

set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

alias git /usr/local/bin/git
alias nv nvim
alias nerd 'nvim +NERDTree'
alias vundle 'nvim +PluginUpdate +qall'
alias gitclean 'git branch --merged master | grep -v " master" | grep -v "\*" | xargs -n 1 git branch -d'

# Abbreviations
## Mo Git Mo Problems
abbr --add gad git add --all
abbr --add gap git add --patch
abbr --add gc git commit -v
abbr --add gp git push
abbr --add gpu git pull
abbr --add gst git status

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
test -e {$HOME}/.fish.local ; and source {$HOME}/.fish.local

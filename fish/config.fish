if status --is-interactive
  set PATH /usr/bin /bin /usr/sbin /sbin
  set PATH $HOME/Applications /usr/local/bin /usr/local/sbin $PATH
  if test -x /opt/chefdk/bin/chef; or test -x (which chef)
    eval (/opt/chefdk/bin/chef shell-init fish)
  end

  if test -x "/usr/local/bin/archey"
      /usr/local/bin/archey --color
  else if test -x "/usr/local/bin/bsdinfo"
      /usr/local/bin/bsdinfo
  end

  if test -x "/usr/local/bin/thefuck"
    eval (thefuck --alias | tr '\n' ';')
  end

  fish_vi_key_bindings
  set -g __fish_vi_mode 1
end

if test -z "$TMUX"
  set TERM screen-256color
end

set -x EDITOR nvim

set -x GOPATH ~/Code/gocode

# I use vmware
set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion

set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

alias git /usr/local/bin/git
alias git hub
alias vim nvim
alias ce 'chef exec'
alias vundle 'vim +PluginUpdate +qall'
alias gitclean 'git branch --merged master | grep -v " master" | grep -v "\*" | xargs -n 1 git branch -d'

# Abbreviations
abbr --add tp chef exec thor version:bump auto
abbr --add vmrun '/Applications/VMware\ Fusion.app//Contents/Library/vmrun'
## Mo Git Mo Problems
abbr --add gad git add --all
abbr --add gap git add --patch
abbr --add gc git commit -v
abbr --add gp git push
abbr --add gpu git pull
abbr --add gst git status
abbr --add gft git fetch --tags

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
test -e {$HOME}/.fish.local ; and source {$HOME}/.fish.local

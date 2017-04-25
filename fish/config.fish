if status --is-interactive
  set PATH $HOME/Applications /usr/local/bin /usr/local/sbin $PATH
end

fish_vi_key_bindings
set -g __fish_vi_mode 1

if test -z "$TMUX"
  set TERM screen-256color
end

set -x EDITOR nvim

# I use vmware
set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion

set -e GREP_OPTIONS
set -x GREP_COLOR "1;33"
set -x ACK_COLOR_MATCH "bold yellow"

alias tmux "direnv exec / tmux"
alias git hub
alias vim nvim
alias vif 'fzf | read -l result; and vim $result'
alias gitclean 'git branch --merged master | grep -v " master" | grep -v "\*" | xargs -n 1 git branch -d'

# Abbreviations
abbr --add cf fzf-cd-widget
abbr --add ce chef exec
abbr --add vmrun '/Applications/VMware\ Fusion.app//Contents/Library/vmrun'
## Mo Git Mo Problems
abbr --add gad git add --all
abbr --add gap git add --patch
abbr --add gca git commit --signoff --amend --date="(date)"
abbr --add gc git commit --signoff --verbose
abbr --add gp git push
abbr --add gpt "git push; and git push --tags"
abbr --add gpu git pull
abbr --add gst git status
abbr --add gft git fetch --tags
abbr --add gpr git pull-request

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

test -x /usr/local/bin/direnv; and eval (direnv hook fish)

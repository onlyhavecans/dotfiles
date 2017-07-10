if status --is-interactive
  set PATH $HOME/Applications /usr/local/bin /usr/local/sbin $PATH
end

## Some rust
set -l rustup_path $HOME/.cargo/bin
if [ $CARGO_HOME ]
  set rustup_path $CARGO_HOME/bin
end
contains -- $rustup_path $PATH
  or set -gx PATH $rustup_path $PATH
set RUST_SRC_PATH $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

set fish_key_bindings my_key_bindings

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
abbr --add ag rg
abbr --add cf fzf-cd-widget
abbr --add ce chef exec
abbr --add cebu chef exec berks update
abbr --add camp 'thor dnsimple:campsite_cookbook'
abbr --add vmrun '/Applications/VMware\ Fusion.app//Contents/Library/vmrun'
abbr --add yt youtube-dl
abbr --add j "cd ~/"
## Mo Git Mo Problems
abbr --add gad git add --all
abbr --add gap git add --patch
abbr --add gca git commit --signoff --amend --date="(date)"
abbr --add gc git commit --signoff --verbose
abbr --add gp git push
abbr --add gpu git pull
abbr --add gst git status
abbr --add gft git fetch --tags
abbr --add gpr "git push; and git pull-request --browse"
abbr --add gbr git browse

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
test -e {$HOME}/.local.fish ; and source {$HOME}/.local.fish

test -x /usr/local/bin/direnv; and eval (direnv hook fish)

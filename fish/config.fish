#config.d/00preload_functions.fish
function prepend_path
  if not test 1 -eq (count $argv)
    echo "only one path at a time"
    return 1
  end

  set -l my_path $argv
  contains -- $my_path $PATH
    or set -x PATH $my_path $PATH
end

function append_path
  if not test 1 -eq (count $argv)
    echo "only one path at a time"
    return 1
  end

  set -l my_path $argv
  contains -- $my_path $PATH
    or set -x PATH $PATH $my_path
end

#config.d/10path.fish
## I like being strict with my path in shells
if status is-interactive
  set -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin
  set -Ue fish_user_paths

  set -l prepend_dirs $HOME/bin $HOME/Applications
  for dir in $prepend_dirs
    test -d $dir; and set -x PATH $dir $PATH
  end

  set -l append_dirs /opt/X11/bin
  for dir in $append_dirs
    test -d $dir; and set -x PATH $PATH $dir
  end
end

#config.d/20homeshick.fish
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
homeshick refresh --quiet --batch

#config.d/20pgapp.fish
set -l pg_app /Applications/Postgres.app/Contents/Versions/latest/bin
if test -d $pg_app
  append_path $pg_app
end

## Some rust
set -l rustup_path $HOME/.cargo/bin
if test -n $CARGO_HOME
  set -l rustup_path $CARGO_HOME/bin
end

append_path $rustup_path
set -x RUST_SRC_PATH $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

#config.d/25go.fish
## go for golang
set -l go_path $HOME/go
set -l go_bin $go_path/bin

append_path $go_bin

#config.d/30editor.fish
alias vim nvim
set -x EDITOR nvim

#config.d/30term.fish
if test -z "$TMUX"
  set TERM screen-256color
end

#config.d/30vagrant.fish
# I sometimes use vmware
if test -x '/Applications/VMware\ Fusion.app/Contents/Library/vmrun'
  set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion
else
  set -x VAGRANT_DEFAULT_PROVIDER virtualbox
end

#config.d/40chef.fish
if status --is-interactive
  abbr --add --global ce chef exec
  abbr --add --global cebu chef exec berks update
end

# fzf in fish
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --no-ignore-vcs'
if status --is-interactive
  alias c "cd (fd . --full-path ~ --type d --no-ignore-vcs| fzf)"
  alias v "nvim (fzf)"
end

#config.d/40exa.fishj
alias ls exa

#config.d/40git.fish
## Mo Git Mo Problems
if status --is-interactive
  alias git hub
  alias g hub
  abbr --add --global gad git add --all
  abbr --add --global gap git add --patch
  abbr --add --global gca git commit --signoff --amend --date="(date)"
  abbr --add --global gc git commit --signoff --verbose
  abbr --add --global gp git push
  abbr --add --global gpu git pull
  abbr --add --global gst git status
  abbr --add --global gft git fetch --tags
  abbr --add --global gbr git browse
end

#config.d/40gpg.fish
set -x GPG_TTY (tty)

#config.d/90iterm.fish
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

#config.d/99direnv.fish
if test -x /usr/local/bin/direnv
  direnv hook fish | source
  alias tmux "direnv exec / tmux"
end

## Mosh
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
set -x MOSH_SERVER_SIGNAL_TMOUT 60
# Clean up any session that has not been connected to in 30 days
set -x MOSH_SERVER_NETWORK_TMOUT 2592000
if status --is-interactive
  abbr --add --global cleanmosh killall -USR1 mosh-server
end

## ASDF manager
test -e /usr/local/opt/asdf/asdf.fish; and source /usr/local/opt/asdf/asdf.fish

#config.d/99local.fish
test -e {$HOME}/.config/local/config.fish; and source {$HOME}/.config/local/config.fish

###
## Start with Functions
###

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

###
## All the stuff that should only happen if interactive
###

if status --is-interactive
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

  # Homeshick is important
  source "$HOME/.homesick/repos/homeshick/homeshick.fish"
  source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

  # I am lazy with neovim
  alias vim nvim
  set -x EDITOR nvim

  # Fix tmux term
  if test -z "$TMUX_PANE"
    set TERM screen-256color
  end

  # Chef is important
  abbr --add --global ce chef exec

  # fzf in fish
  alias c "cd (fd . --full-path ~ --type d --no-ignore-vcs| fzf)"
  alias d "cd (fd . --type d --no-ignore-vcs| fzf)"
  alias v "nvim (fzf)"

  # I prefer Exa
  alias ls exa

  # Mo Git Mo Problems
  alias git hub
  alias g hub
  abbr --add --global gad git add --all
  abbr --add --global gap git add --patch
  abbr --add --global gc git commit --signoff --verbose
  abbr --add --global gp git push
  abbr --add --global gpu git pull
  abbr --add --global gm git switch master
  abbr --add --global gst git status
  abbr --add --global cleandir git clean -ffdx -e .envrc

  # Make iTerm Happy
  test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

  # Quick Mosh alias
  abbr --add --global cleanmosh killall -USR1 mosh-server

end ## The end of interactive only

###
## GLobals & Non-Interactive Settings
###

# I like PRG AP
set -l pg_app /Applications/Postgres.app/Contents/Versions/latest/bin
if test -d $pg_app
  append_path $pg_app
end

# Get Rusty
set -l rustup_path $HOME/.cargo/bin
if test -n $CARGO_HOME
  set -l rustup_path $CARGO_HOME/bin
end
append_path $rustup_path
set -x RUST_SRC_PATH $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

# go for golang
set -l go_path $HOME/go
set -l go_bin $go_path/bin
append_path $go_bin


# I sometimes use vmware
if test -x '/Applications/VMware Fusion.app/Contents/Library/vmrun'
  set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion
else
  set -x VAGRANT_DEFAULT_PROVIDER virtualbox
end

# This hotfix makes GPG less annoying
set -x GPG_TTY (tty)

# No java in my erlang
set -x KERL_CONFIGURE_OPTIONS --without-javac

# Global FZF setting
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --no-ignore-vcs'

# Direnv makes life easier but needs az tmux fix
if test -x /usr/local/bin/direnv
  direnv hook fish | source
  alias tmux "direnv exec / tmux"
end

## Mosh
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
set -x MOSH_SERVER_SIGNAL_TMOUT 60
# Clean up any session that has not been connected to in 30 days
set -x MOSH_SERVER_NETWORK_TMOUT 2592000

# ASDF Makes polyglots happy
test -e /usr/local/opt/asdf/asdf.fish; and source /usr/local/opt/asdf/asdf.fish

###
## Sauce Local
###
test -e {$HOME}/.config/local/config.fish; and source {$HOME}/.config/local/config.fish

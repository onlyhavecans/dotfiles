#shellcheck shell=zsh

# Path Stuff
function append_path() {
  if [[ -d "$*" ]]; then
    path+=("$*")
  fi
}

append_path "$HOME/bin"
append_path "$HOME/Applications"
append_path "$HOME/go/bin"

export PATH

export EDITOR=vim

## Make do cvs prompt
if [[ ! -f ~/.zsh/git-prompt.zsh/git-prompt.zsh ]]; then
  >&2 echo "git-prompt is missing https://github.com/woefe/git-prompt.zsh"
  mkdir -p ~/.zsh
  git clone --depth=1 https://github.com/woefe/git-prompt.zsh ~/.zsh/git-prompt.zsh
fi
ZSH_GIT_PROMPT_SHOW_STASH=1
source ~/.zsh/git-prompt.zsh/git-prompt.zsh
export PROMPT='%m:%2~ $(gitprompt)[%(?.%F{green}.%F{red})%?%f] '

# Homeshick does the goods
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# asdf-vm
if builtin whence -p asdf &> /dev/null; then
  source "/usr/local/opt/asdf/asdf.sh"
  # For asdf-erlang
  export KERL_CONFIGURE_OPTIONS=--without-javac
fi

# direnv
if builtin whence direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
  alias tmux="direnv exec / tmux"
fi

# Vagrant
if builtin whence vagrant &> /dev/null; then
  if [[ -x '/Applications/VMware Fusion.app/Contents/Library/vmrun' ]]; then
    VAGRANT_DEFAULT_PROVIDER=vmware_fusion
  else
    VAGRANT_DEFAULT_PROVIDER=virtualbox
  fi
  export VAGRANT_DEFAULT_PROVIDER
fi

## Mosh
if builtin whence mosh-server &> /dev/null; then
  # make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
  export MOSH_SERVER_SIGNAL_TMOUT=60
  # Clean up any session that has not been connected to in 30 days
  export MOSH_SERVER_NETWORK_TMOUT=2592000
fi

## Aliases
if builtin whence exa &> /dev/null; then
  alias ls=exa
  alias la="exa -a"
  alias ll="exa -l"
  alias lla="exa -la"
fi

alias cl=clear

if builtin whence hub &> /dev/null; then
  alias git=hub
  alias g=hub
fi

alias gad="git add --all"
alias gap="git add --patch"
alias gc="git commit --signoff --verbose"
alias gpl="git pull"
alias gps="git push"
alias gst="git status"

alias tm="tmux attach -c ~ || tmux"
alias ts="mosh colo01.squirrels.wtf -- tmux attach -c ~"

alias subp="subl *.sublime-project"

if [[ -f "$HOME/.config/local/zshrc" ]]; then
  source "$HOME/.config/local/zshrc"
fi

if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

autoload -Uz compinit && compinit

#shellcheck shell=zsh
#shellcheck disable=SC1090,SC1091

# Path Stuff
[ -d "$HOME/bin" ]          && path+=("$HOME/bin")
[ -d "$HOME/Applications" ] && path+=("$HOME/Applications")
[ -d "$HOME/go/bin" ]       && path+=("$HOME/go/bin")
export PATH


# Homeshick for configs
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath+=("$HOME/.homesick/repos/homeshick/completions")


# asdf-vm
if [ -f /usr/local/opt/asdf/asdf.sh ]; then
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
  if builtin whence vmrun &> /dev/null; then
    VAGRANT_DEFAULT_PROVIDER=vmware_fusion
  else
    VAGRANT_DEFAULT_PROVIDER=virtualbox
  fi
  export VAGRANT_DEFAULT_PROVIDER
fi


## Replace a few commands
if builtin whence exa &> /dev/null; then
  alias ls=exa
  alias la="exa -a"
  alias ll="exa -l"
  alias lla="exa -la"
fi

if builtin whence hub &> /dev/null; then
  alias git=hub
  alias g=hub
fi


## Aliases
alias ce="chef exec"

alias cl=clear

alias gc="git commit --signoff --verbose"
alias gad="git add --all"
alias gap="git add --patch"
alias gpl="git pull"
alias gps="git push"
alias gst="git status"

alias sp="subl *.sublime-project"

alias tm="tmux attach -c ~ || tmux"
alias ts="mosh colo01.squirrels.wtf -- tmux attach -c ~"


## Git Prompt speeds up my workflow
if [ ! -d "$HOME/.homesick/repos/typewritten" ]; then
  homeshick clone https://github.com/reobin/typewritten.git
fi
fpath+=("$HOME/.homesick/repos/typewritten")
autoload -U promptinit; promptinit
prompt typewritten


## Emacs keys
bindkey -e
setopt autocd


## FZF to get around & use fd for performance
if builtin whence fzf &> /dev/null; then
  source "/usr/local/opt/fzf/shell/completion.zsh"
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"

  export FZF_DEFAULT_COMMAND='fd --follow --type f'
  export FZF_CTRL_T_COMMAND='fd --follow'

  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi


## Per Machine Configurations
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

if [ -d "$HOME/.config/local/zshrc.d" ]; then
  source "$HOME/.config/local/zshrc.d"/*
fi


## Completions
autoload -Uz compinit && compinit

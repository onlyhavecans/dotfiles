#shellcheck shell=zsh
#shellcheck disable=SC1090,SC1091

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


# homebrew completions
if builtin whence -p brew &>/dev/null; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi


# Homeshick does the goods
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=("$HOME/.homesick/repos/homeshick/completions" $fpath)


## Make do cvs prompt
if [[ ! -f ~/.homesick/repos/git-prompt.zsh/git-prompt.zsh ]]; then
  homeshick clone https://github.com/woefe/git-prompt.zsh
fi
source "$HOME/.homesick/repos/git-prompt.zsh/git-prompt.zsh"
export PROMPT='%m:%F{green}%2~%f $(gitprompt)%(?.%F{green}.%F{red})%?%f %# '


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
  if builtin whence vmrun &> /dev/null; then
    VAGRANT_DEFAULT_PROVIDER=vmware_fusion
  else
    VAGRANT_DEFAULT_PROVIDER=virtualbox
  fi
  export VAGRANT_DEFAULT_PROVIDER
fi


## Replace commands
export EDITOR=vim

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
alias cl=clear

alias gad="git add --all"
alias gap="git add --patch"
alias gc="git commit --signoff --verbose"
alias gpl="git pull"
alias gps="git push"
alias gst="git status"

alias subp="subl *.sublime-project"

alias tm="tmux attach -c ~ || tmux"
alias ts="mosh colo01.squirrels.wtf -- tmux attach -c ~"


## Locals
if [[ -d "$HOME/.config/local/zshrc.d" ]]; then
  source "$HOME/.config/local/zshrc.d/*"
fi

if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi


## Turn on features
autoload -Uz compinit && compinit

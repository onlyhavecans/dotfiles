#shellcheck shell=zsh
#shellcheck disable=SC1090,SC1091

# Path Stuff
[ -d "$HOME/bin" ]          && path+=("$HOME/bin")
[ -d "$HOME/Applications" ] && path+=("$HOME/Applications")
[ -d "$HOME/go/bin" ]       && path+=("$HOME/go/bin")
export PATH


# Homeshick for configs
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=("$HOME/.homesick/repos/homeshick/completions" $fpath)


## Git Prompt speeds up my workflow
if [ ! -f ~/.homesick/repos/git-prompt.zsh/git-prompt.zsh ]; then
  homeshick clone https://github.com/woefe/git-prompt.zsh
fi
source "$HOME/.homesick/repos/git-prompt.zsh/git-prompt.zsh"
export PROMPT='%m:%F{green}%2~%f $(gitprompt)%(?.%F{green}.%F{red})%?%f %# '


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


# FZF to get around & use fd for performance
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --follow --type f'
  export FZF_CTRL_T_COMMAND='fd --follow'
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi


## Replace a few commands
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

alias sp="subl *.sublime-project"

alias tm="tmux attach -c ~ || tmux"
alias ts="mosh colo01.squirrels.wtf -- tmux attach -c ~"


## Per Machine Configurations
if [ -d "$HOME/.config/local/zshrc.d" ]; then
  source "$HOME/.config/local/zshrc.d/*"
fi

if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi


## Turn on features
autoload -Uz compinit && compinit

#shellcheck shell=zsh
#shellcheck disable=SC1090,SC1091

# Path Stuff
path=(/usr/local/bin /usr/local/sbin $path)
[ -d "$HOME/.cargo/bin" ] && path=("$HOME/.cargo/bin" $path)
[ -d "$HOME/go/bin" ]     && path=("$HOME/go/bin" $path)
[ -d "$HOME/bin" ]        && path=("$HOME/bin" $path)

[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ] && \
  path=($path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin")

# Homeshick for configs
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath+=("$HOME/.homesick/repos/homeshick/completions")


# asdf-vm
if [ -f $HOME/.asdf/asdf.sh ]; then
  source "$HOME/.asdf/asdf.sh"
  fpath+=("${ASDF_DIR}/completions")
  export KERL_CONFIGURE_OPTIONS=--without-javac
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
fi


# direnv
if builtin whence direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
  alias tmux="direnv exec / tmux"
fi


## Replace a few commands
if builtin whence nvim &> /dev/null; then
  alias vim=nvim
  export EDITOR=nvim
fi

if builtin whence exa &> /dev/null; then
  alias ls=exa
  alias la="exa -a"
  alias ll="exa -l"
  alias lla="exa -la"
fi

if builtin whence hub &> /dev/null; then
  alias git=hub
fi


## Aliases
alias ce="chef exec"
alias cet="chef exec thor"
alias cek="chef exec knife"

alias cl=clear

alias G=git

alias tm="tmux attach -c ~ || tmux"
alias ts="mosh colo01.squirrels.wtf -- tmux attach -c ~"


## Simplify Prompt
export PROMPT='%F{green}%2~%f %(?.%F{blue}.%F{red}%?)❯%f '
## Put branch in right
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b %F{magenta}%m%u%c%f'
precmd() { vcs_info }
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_


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

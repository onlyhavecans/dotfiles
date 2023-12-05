#shellcheck shell=zsh
#shellcheck disable=SC1090,SC1091

## Make sure system paths are last
eval $(brew shellenv)

## brew --prefix is way too slow in 4.0 so hardcode
function brew_prefix {
  HOMEBREW_PREFIX_OPT="${HOMEBREW_PREFIX}/opt"
  echo "${HOMEBREW_PREFIX_OPT}/$1"
}


# Homeshick for configs
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath+=("$HOME/.homesick/repos/homeshick/completions")


# asdf-vm
if [ -f $HOME/.asdf/asdf.sh ]; then
  source "$HOME/.asdf/asdf.sh"
  fpath+=("${ASDF_DIR}/completions")
  export ASDF_GOLANG_MOD_VERSION_ENABLED=false
  export KERL_CONFIGURE_OPTIONS=--without-javac
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew_prefix openssl@1.1)"
fi


# direnv
if builtin whence direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
  alias tmux="direnv exec / tmux"
fi


# Brew overlays
apps=(openssh whois curl libpq)
for app in $apps; do
  [ -d "$(brew_prefix $app)/bin" ] && \
    path=("$(brew_prefix $app)/bin" $path)
done


## Replace a few commands
if builtin whence eza &> /dev/null; then
  alias ls=eza
  alias la="eza -a"
  alias ll="eza -l"
  alias lla="eza -la"
fi


## Aliases
alias ce="chef exec"
alias cet="chef exec thor"
alias cek="chef exec knife"

alias cl=clear

alias g=git
alias G=git

alias lg="XDG_CONFIG_HOME="$HOME/.config" lazygit"
alias lzd="lazydocker"

alias tm="tmux new-session -A -c ~"
alias ts="mosh colo01.squirrels.wtf -- tmux new-session -A -c ~"
alias tp="mosh piper.local -- tmux new-session -A -c ~"

alias venv="python3 -m venv"
alias activate="source venv/bin/activate"


## Simplify Prompt
export PROMPT='%F{green}%2~%f %(?.%F{blue}.%F{red}%?)❯%f '


## Emacs keys
bindkey -e
setopt autocd


## FZF to get around & use fd for performance
if builtin whence fzf &> /dev/null; then
  source "$(brew_prefix fzf)/shell/completion.zsh"
  source "$(brew_prefix fzf)/shell/key-bindings.zsh"

  export FZF_DEFAULT_COMMAND='fd --follow --hidden --type f'
  export FZF_CTRL_T_COMMAND='fd --follow --hidden'

  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi


## Per Machine Configurations
zsh_local="$HOME/.config/local/zshrc.d"
if [ -d "$zsh_local" ]; then
  for f in "$zsh_local"/*; do
    source "$f"
  done
fi


## Completions
autoload -Uz compinit && compinit

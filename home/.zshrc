#shellcheck shell=zsh

#
## ZSH Settings
#

# Turn on slow query logging
REPORTTIME=1

# History
setopt share_history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history

# My Convience Functions
function add_path_if_exists {
  [ -d "$1" ] && path=("$1" $path)
}

function command_exists {
  builtin whence "$1" &>/dev/null
}

# Autoload things not used in shell startup
typeset -U fpath
local my_functions=~/.config/zsh/functions
fpath=($my_functions $fpath)
autoload -Uz ${my_functions}/*(:t)

# Emacs keys
bindkey -e
setopt autocd

# Completion hacking
mkdir -p ~/.cache/zsh
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _expand_alias _complete _ignored # tab complete aliases

#
## Paths
#
# Make sure system paths are last
if command_exists brew; then
  source <(brew shellenv zsh)
  export HOMEBREW_NO_ENV_HINTS=1

  ## brew --prefix is way too slow in 4.0 so hardcode
  function _brew_prefix {
    printf "${HOMEBREW_PREFIX}/opt/$1"
  }

  # Brew overlays
  apps=(openssh whois curl libpq)
  for app in $apps; do
    [ -d "$(_brew_prefix $app)/bin" ] &&
      path=("$(_brew_prefix $app)/bin" $path)

    # completions
    [ -d "$(_brew_prefix $app)/share/zsh/site-functions" ] &&
      fpath+=("$(_brew_prefix $app)/share/zsh/site-functions")
  done

  unfunction _brew_prefix
fi

# Homeshick for configs
if [ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  fpath+=("$HOME/.homesick/repos/homeshick/completions")
  alias hcd="homeshick cd"
  alias htrack="homeshick track"
fi

# asdf-vm
if command_exists asdf; then
  source ${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh
  export ASDF_GOLANG_MOD_VERSION_ENABLED=false
  unset RUBY_CONFIGURE_OPTS
fi

# direnv
if command_exists direnv; then
  source <(direnv hook zsh)
  alias tmux="direnv exec / tmux"
fi

# uv and local apps
add_path_if_exists "$HOME/.local/bin"

# Wezterm
add_path_if_exists "$WEZTERM_EXECUTABLE_DIR"

# Generic overlays
if command_exists nvim; then
  alias nv=nvim
  EDITOR=nvim
  VISUAL=nvim
else
  EDITOR=vi
  VISUAL=vi
fi
export EDITOR VISUAL

if command_exists bat; then
  export BAT_THEME=gruvbox-dark
  source <(batman --export-env)
  alias pretty=prettybat

  # Customize all usage of --help
  # alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi

if command_exists eza; then
  alias ls=eza
  alias la="eza -a"
  alias ll="eza -l"
  alias lla="eza -la"
  alias tree="eza --tree"
fi

if command_exists fzf; then
  source <(fzf --zsh)

  export FZF_DEFAULT_COMMAND='fd --follow --hidden --type f'
  export FZF_CTRL_T_COMMAND='fd --follow --hidden'
  export FZF_ALT_C_COMMAND='fd --follow --hidden --type d'

  if [[ -n "$TMUX" ]]; then
    export FZF_TMUX_OPTS='-p80%,60%'
  fi
fi

if command_exists zoxide; then
  source <(zoxide init zsh)
fi

#
## Aliases
#
alias ce="chef exec"
alias cet="chef exec thor"
alias cek="chef exec knife"

alias cl=clear

alias g=git

alias lg=lazygit
alias lzd=lazydocker
alias gv="lazygit --path=$HOME/Documents/Obsidian/Vault/"

alias tm="tmux new-session -A -c ~"
alias tp="mosh piper.local -- tmux new-session -A -c ~"
alias tc="mosh catra.local -- tmux new-session -A -c ~"

#
## Prompt
#
autoload -U promptinit
promptinit
prompt skwrl

#
## Per Machine Configurations
#
zsh_local="$HOME/.config/zsh.d"
if [ -d "$zsh_local" ]; then
  for f in "$zsh_local"/*; do
    source "$f"
  done
fi

#
## Completions always last
#
autoload -Uz compinit && compinit
export PATH

#shellcheck shell=zsh

#
## ZSH Settings
#

## Disable flow control for C-s & C-q
stty -ixon

# Turn on slow query logging
REPORTTIME=1

# History
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
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
  # >=0.16.0
  shims_path="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  add_path_if_exists "$shims_path"

  export ASDF_GOLANG_MOD_VERSION_ENABLED=false
  unset RUBY_CONFIGURE_OPTS
fi

# direnv
if command_exists direnv; then
  # source <(direnv hook zsh)
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
  alias cat=bat
  alias jbat="bat -l json"

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

if command_exists op; then
  alias o="op run -- "
  [ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"
fi

if command_exists xh; then
  alias http=xh
  alias https=xhs
fi

if command_exists zoxide; then
  source <(zoxide init zsh)
fi

if command_exists claude; then
  alias c=claude
  alias cc="claude --continue"
fi

#
## Aliases
#

# hack around mac/linux
if ! command_exists xdg-open; then
  alias xdg-open=open
elif ! command_exists open; then
  alias open=xdg-open
fi

alias ce="chef exec"
alias cet="chef exec thor"
alias cek="chef exec knife"

alias cl=clear

alias g=git
alias grs="git remote set-url origin"

alias lg=lazygit
alias gv="lazygit --path=$HOME/Documents/Obsidian/Vault/"
alias lzd=lazydocker

alias tf=terraform
alias plan="terraform plan -out=tfplan | bat"

alias tm="tmux new-session -A -c ~"
alias tp="mosh piper.bunni.biz -- tmux new-session -A -c ~"
alias tw="mosh webby.bunni.biz -- tmux new-session -A -c ~"

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

#
## Drop a fastfetch unless in tmux
#
if [[ -z "$TMUX" ]]; then
  fastfetch
fi

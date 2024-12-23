#shellcheck shell=zsh

## Convenience Functions
function add_path_if_exists {
  [ -d "$1" ] && path=("$1" $path)
}

function command_exists {
  builtin whence "$1" &>/dev/null
}

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

# TODO: Make this an autoload someday
function zsh_stats {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
}

# Emacs keys
bindkey -e
setopt autocd

# Completion hacking
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
fi

# Homeshick for configs
if [ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  fpath+=("$HOME/.homesick/repos/homeshick/completions")
  alias hcd="homeshick cd"
  alias htrack "homeshick track"
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
  export MANPAGER="nvim +Man!"
else
  EDITOR=vi
  VISUAL=vi
fi
export EDITOR VISUAL

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

if command_exists yazi; then
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
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
alias G=git

alias lg=lazygit
alias lzd=lazydocker
alias gv="lazygit --path=$HOME/Documents/Obsidian/Vault/"

alias tm="tmux new-session -A -c ~"
alias tp="mosh piper.local -- tmux new-session -A -c ~"
alias tc="mosh catra.local -- tmux new-session -A -c ~"
alias tw="mosh webby.local -- tmux new-session -A -c ~"

alias venv="python3 -m venv"
alias mkvenv="python3 -m venv venv"
alias activate="source venv/bin/activate"

#
## Prompt with Git info
#
function _git_info_cmd {
  command git --no-optional-locks status --porcelain=v2 --branch --show-stash 2>&1
}

function _git_info_parse {
  local git_status="$1"

  local ahead='↑'
  local behind='↓'
  local stash='$'
  local staged='+'
  local modified='!'
  local untracked='?'
  local branch
  local -Ua symbols

  while IFS= read -r line; do
    case $line in
      "# branch.oid"*) ;;
      "# branch.upstream"*) ;;
      "# branch.head"*)
        branch=$(echo $line | cut -d' ' -f 3)
        ;;
      "# branch.ab"*)
        local ahead_count behind_count
        read ahead_count behind_count <<<$(echo "$line" | cut -d' ' -f 3,4 | tr -d '+-')
        [[ $ahead_count > 0 ]] && symbols+="$ahead"
        [[ $behind_count > 0 ]] && symbols+="$behind"
        ;;
      "# stash"*) symbols+="$stash" ;;
      [12]\ ?[MTADRC]*) symbols+="$modified" ;;
      [12]\ [MTADRC]?*) symbols+="$staged" ;;
      ?\ *) symbols+="$untracked" ;;
      *) symbols+=$line ;;
    esac
  done <<<$git_status

  echo -n "$branch" "${symbols// /}"
}

function _git_info_prompt {
  local branch=$1
  local symbols=$2

  [[ -n $symbols ]] && branch+=" $symbols"
  echo "  $branch"
}

function _git_info {
  local git_status=$(_git_info_cmd)
  if [[ "$git_status" == fatal:* ]]; then
    return
  fi

  local branch symbols
  read -r branch symbols <<<"$(_git_info_parse $git_status)"

  _git_info_prompt "$branch" "$symbols"
}

setopt prompt_subst
TOP_PROMPT=''
TOP_PROMPT+='%F{yellow}[%D{%H:%M:%S}]%f ' # Yellow time
TOP_PROMPT+='%F{green}%m'                 # Green Machine name
TOP_PROMPT+='  %2~%f'                    # Green Current directory
TOP_PROMPT+='%F{magenta}$(_git_info)%f'   # Magenta Git info
precmd() {
  print -rP -- $TOP_PROMPT
}
PROMPT='%(?.%F{blue}.%F{red}%?)❯%f ' # Blue chevron, Red with error num if last command failed

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

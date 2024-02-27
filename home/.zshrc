#shellcheck shell=zsh
#shellcheck disable=SC1090,SC1091

## Make sure system paths are last
eval $(brew shellenv)

## brew --prefix is way too slow in 4.0 so hardcode
function _brew_prefix {
  printf "${HOMEBREW_PREFIX}/opt/$1"
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
  unset RUBY_CONFIGURE_OPTS
fi

# direnv
if builtin whence direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
  alias tmux="direnv exec / tmux"
fi

## Wezterm
if [ -n "$WEZTERM_EXECUTABLE_DIR" ]; then
  path=("$WEZTERM_EXECUTABLE_DIR" $path)
fi

# Brew overlays
apps=(openssh whois curl libpq)
for app in $apps; do
  [ -d "$(_brew_prefix $app)/bin" ] &&
    path=("$(_brew_prefix $app)/bin" $path)

  [ -d "$(_brew_prefix $app)/share/zsh/site-functions" ] &&
    fpath+=("$(_brew_prefix $app)/share/zsh/site-functions")
done

if builtin whence eza &>/dev/null; then
  alias ls=eza
  alias la="eza -a"
  alias ll="eza -l"
  alias lla="eza -la"
  alias tree="eza --tree"
fi

if builtin whence zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

## Aliases
alias ce="chef exec"
alias cet="chef exec thor"
alias cek="chef exec knife"

alias cl=clear

alias g=git
alias G=git

alias lg="XDG_CONFIG_HOME="$HOME/.config" lazygit"
alias lzd="XDG_CONFIG_HOME="$HOME/.config" lazydocker"

alias tm="tmux new-session -A -c ~"
alias tp="mosh piper.local -- tmux new-session -A -c ~"
alias tc="mosh catra.local -- tmux new-session -A -c ~"

alias venv="python3 -m venv"
alias activate="source venv/bin/activate"

## Prompt with Git info
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

  [[ -n $symbols ]] && branch+="$symbols"
  echo " $branch"
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
TOP_PROMPT+='%F{green}%m '               # Green Machine name
TOP_PROMPT+=' %2~%f '                  # Green Current directory
TOP_PROMPT+='%F{magenta}$(_git_info)%f' # Magenta Git info
precmd() { print -rP -- $TOP_PROMPT }
PROMPT='%(?.%F{blue}.%F{red}%?)❯%f ' # Blue chevron, Red with error num if last command failed

## Emacs keys
bindkey -e
setopt autocd

## FZF to get around & use fd for performance
if builtin whence fzf &>/dev/null; then
  source "$(_brew_prefix fzf)/shell/completion.zsh"
  source "$(_brew_prefix fzf)/shell/key-bindings.zsh"

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
zsh_local="$HOME/.config/zsh.d"
if [ -d "$zsh_local" ]; then
  for f in "$zsh_local"/*; do
    source "$f"
  done
fi

## Completions
autoload -Uz compinit && compinit

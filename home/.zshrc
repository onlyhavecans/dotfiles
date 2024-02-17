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
  unset RUBY_CONFIGURE_OPTS
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
alias lzd="XDG_CONFIG_HOME="$HOME/.config" lazydocker"

alias tm="tmux new-session -A -c ~"
alias tp="mosh piper.local -- tmux new-session -A -c ~"
alias tc="mosh catra.local -- tmux new-session -A -c ~"

alias venv="python3 -m venv"
alias activate="source venv/bin/activate"


## My own Git Prompt
function _git_symbols {
	# Symbols
	local ahead='↑'
	local behind='↓'
	local diverged='↕'
	local stashed='$'
	local staged='+'
	local modified='!'
	local untracked='?'

  typeset -Ua output

  # Only run a single git command
	local git_status
	git_status="$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)"

  # Safety check
  if [[ $? -ne 0 ]]; then
    echo "git_err"
    return
  fi

	# Ahead, Behind, Diverged
	local ahead_count behind_count is_ahead is_behind
  read ahead_count behind_count <<< $(echo "$git_status" | awk '/^# branch.ab/ {print $3,$4}' | tr -d '+-')
  [[ $ahead_count != 0 ]]  && is_ahead=true
  [[ $behind_count != 0 ]] && is_behind=true
  if [[ $is_ahead && $is_behind ]]; then
    output+="$diverged"
  else
    [[ $is_ahead ]]  && output+="$ahead"
    [[ $is_behind ]] && output+="$behind"
  fi

  # Stashed, Untracked, Staged, Modified
	while IFS= read -r symbol; do
		case $symbol in
      "# stash"*) output+="$stashed";;
			"? "*)      output+="$untracked";;
			??.?*)      output+="$staged";;
      ???.*)      output+="$modified";;
		esac
	done <<< "$git_status"

  echo -n "${output// /}"
}

function _git_info {
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local -a git_info

		git_info+="$(git symbolic-ref --short HEAD 2>/dev/null)"

    ## These can be empty
    symbols=$(_git_symbols)
    [[ -n $symbols ]] && git_info+="$symbols"
		echo "($git_info) "
	fi
}

setopt prompt_subst
PROMPT=''
PROMPT+='%F{green}%2~%f '            # Green Current directory
PROMPT+='%F{magenta}$(_git_info)%f'  # Magenta Git info
PROMPT+='%(?.%F{blue}.%F{red}%?)❯%f' # Blue chevron, Red with error num if last command failed
PROMPT+=' '


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


## Wezterm for terminal
if [ -n "$WEZTERM_EXECUTABLE_DIR" ]; then
    path=("$WEZTERM_EXECUTABLE_DIR" $path)
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

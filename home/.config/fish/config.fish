#
# Environment & paths - needed for non-interactive shells too
#
set -gx LANG en_US.UTF-8
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BAT_THEME gruvbox-dark
set -gx MOSH_SERVER_SIGNAL_TMOUT 60
set -gx MOSH_SERVER_NETWORK_TMOUT 2592000

# 1Password SSH agent (needed for scripts)
if test -z "$SSH_TTY"; and test -S "$HOME/.1password/agent.sock"
    set -gx SSH_AUTH_SOCK $HOME/.1password/agent.sock
end

# Paths
fish_add_path ~/bin ~/.local/bin ~/.cargo/bin ~/go/bin ~/.asdf/shims

#
# Stop here if not interactive
#
status is-interactive; or return

set -g fish_greeting

# Git prompt config (built-in, no plugins)
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showstashstate yes
set -g __fish_git_prompt_showuntrackedfiles yes
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_char_dirtystate '!'
set -g __fish_git_prompt_char_stagedstate '+'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_stashstate '$'
set -g __fish_git_prompt_char_upstream_ahead '↑'
set -g __fish_git_prompt_char_upstream_behind '↓'

# Abbreviations
abbr -a g git
abbr -a lg lazygit
abbr -a c claude
abbr -a cc "claude --continue"
abbr -a nv nvim
abbr -a tf terraform
abbr -a tm "tmux new-session -A -c ~"
abbr -a hcd "homeshick cd"
abbr -a htrack "homeshick track"

# Tool aliases
type -q bat; and alias cat bat; and alias jbat "bat -l json"; and alias pretty prettybat
type -q eza; and alias ls eza; and alias la "eza -a"; and alias ll "eza -l"; and alias lla "eza -la"; and alias tree "eza --tree"
type -q dua; and alias du dua
type -q duf; and alias df duf
type -q xh; and alias http xh; and alias https xhs
type -q op; and alias o "op run --"

# General aliases
alias cl clear
alias grs "git remote set-url origin"
alias gv "lazygit --path=$HOME/Documents/Obsidian/Vault/"
alias lzd lazydocker
alias plan "terraform plan -out=tfplan | bat"

# Remote tmux sessions
alias tp "mosh piper.bunni.biz -- tmux new-session -A -c ~"
alias tw "mosh webby.bunni.biz -- tmux new-session -A -c ~"

# direnv + tmux integration
type -q direnv; and alias tmux "direnv exec / tmux"

# Tool init
if type -q fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND 'fd --follow --hidden --type f'
    set -gx FZF_CTRL_T_COMMAND 'fd --follow --hidden'
    set -gx FZF_ALT_C_COMMAND 'fd --follow --hidden --type d'
    test -n "$TMUX"; and set -gx FZF_TMUX_OPTS '-p80%,60%'
end
type -q zoxide; and zoxide init fish | source
type -q direnv; and direnv hook fish | source

# Homeshick
test -f ~/.homesick/repos/homeshick/homeshick.fish; and source ~/.homesick/repos/homeshick/homeshick.fish

# Load event handlers (fish lazy-loads functions, but event handlers need registration)
source ~/.config/fish/functions/fish_postexec.fish

# Startup banner (not in tmux)
if test -z "$TMUX"
    type -q fastfetch; and fastfetch
end

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

# Basic Abbreviations
abbr -a --position command l eza
abbr -a --position command la "eza -a"
abbr -a --position command ll "eza -l"
abbr -a --position command lla "eza -la"
abbr -a --position command tree "eza --tree"
abbr -a --position command cl clear
abbr -a --position command nv nvim
abbr -a --position command jbat "bat -l json"
abbr -a --position command pretty prettybat
abbr -a --position command c claude
abbr -a --position command cc "claude --continue"
abbr -a --position command hcd "homeshick cd"
abbr -a --position command htrack "homeshick track"
abbr -a --position command http xh
abbr -a --position command https xhs
abbr -a --position command o "op run --"
abbr -a --position command plan "terraform plan -out=tfplan | bat"
abbr -a --position command tf terraform

# Git abbreviations
abbr -a --position command g git
abbr -a --position command lg lazygit
abbr -a --position command gcm --set-cursor 'git commit -m "%"'
abbr -a --position command gca --set-cursor 'git commit -am "%"'
abbr -a --position command grs "git remote set-url origin"
abbr -a --position command gv "lazygit --path=$HOME/Documents/Obsidian/Vault/"
abbr -a --position command lzd lazydocker

# Shell In Abbreviations
abbr -a --position command tm "direnv exec / tmux new-session -A -c ~"
abbr -a --position command tp "mosh piper.bunni.biz -- tmux new-session -A -c ~"
abbr -a --position command tw "mosh webby.bunni.biz -- tmux new-session -A -c ~"

# Tool init
if type -q fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND 'fd --follow --hidden --type f'
    set -gx FZF_CTRL_T_COMMAND 'fd --follow --hidden'
    set -gx FZF_ALT_C_COMMAND 'fd --follow --hidden --type d'
    test -n "$TMUX"; and set -gx FZF_TMUX_OPTS '-p80%,60%'

    # FZF preview options
    set -gx FZF_CTRL_T_OPTS '--preview "bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || eza -la --color=always {}"'
    set -gx FZF_ALT_C_OPTS '--preview "eza --tree --level=2 --color=always {}"'
end
type -q zoxide; and zoxide init fish | source
type -q direnv; and direnv hook fish | source

# Homeshick
test -f ~/.homesick/repos/homeshick/homeshick.fish; and source ~/.homesick/repos/homeshick/homeshick.fish

# Startup banner (not in tmux)
if test -z "$TMUX"
    type -q fastfetch; and fastfetch
end

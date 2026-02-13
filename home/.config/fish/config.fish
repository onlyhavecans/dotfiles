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
abbr --add --position command cl clear
abbr --add --position command hcd "homeshick cd"
abbr --add --position command htrack "homeshick track"
abbr --add --position command l eza
abbr --add --position command la "eza -a"
abbr --add --position command ll "eza -l"
abbr --add --position command lla "eza -la"
abbr --add --position command ls eza
abbr --add --position command lsusb "cyme --lsusb"
abbr --add --position command n nvim
abbr --add --position command s ssh
abbr --add --position command tree "eza --tree"

# pretty things
abbr --add --position anywhere -- --help '--help 2>&1 | bat --language=help --plain'
abbr --add --position command man batman
abbr --add --position command jbat "bat -l json"
abbr --add --position command pretty prettybat

# Git abbreviations
abbr --add --position command g git
abbr --add --position command lg lazygit
abbr --add --position command gad "git add --all"
abbr --add --position command gca --set-cursor 'git commit -am "%"'
abbr --add --position command gcm --set-cursor 'git commit -m "%"'
abbr --add --position command grs "git remote set-url origin"
abbr --add --position command gs "git switch"
abbr --add --position command gsc "git switch --force-create"
abbr --add --position command gsm "git switch main; and git pull"
abbr --add --position command gv "lazygit --path=$HOME/Documents/Obsidian/Vault/"

# workstuff
abbr --add --position command c claude
abbr --add --position command cc "claude --continue"
abbr --add --position command cs claude-squad
abbr --add --position command http xh
abbr --add --position command https xhs
abbr --add --position command lzd lazydocker
abbr --add --position command o "op run --"
abbr --add --position command plan "terraform plan -out=tfplan | bat"
abbr --add --position command tf terraform

# Shell In Abbreviations
abbr --add --position command tp "mosh piper.bunni.biz -- fish --command tm"
abbr --add --position command tw "mosh webby.bunni.biz -- fish --command tm"

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

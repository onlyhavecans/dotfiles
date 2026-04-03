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
fish_add_path ~/bin ~/.local/bin ~/.cargo/bin ~/go/bin ~/.asdf/shims /usr/local/bin /opt/homebrew/bin /home/linuxbrew/.linuxbrew/bin

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
abbr --add cl clear
abbr --add hcd "homeshick cd"
abbr --add htrack "homeshick track"
abbr --add l eza
abbr --add la "eza -a"
abbr --add ll "eza -l"
abbr --add lla "eza -la"
abbr --add ls eza
abbr --add lsusb "cyme --lsusb"
abbr --add n nvim
abbr --add nv nvim
abbr --add s ssh
abbr --add tree "eza --tree"

# pretty things
abbr --add --position anywhere -- --help '--help 2>&1 | bat --language=help --plain'
abbr --add man batman
abbr --add jbat "bat -l json"
abbr --add pretty prettybat

# Git abbreviations
abbr --add g git
abbr --add lg lazygit
abbr --add gad "git add --all"
abbr --add gca --set-cursor 'git commit -am "%"'
abbr --add gcm --set-cursor 'git commit -m "%"'
abbr --add grs "git remote set-url origin"
abbr --add gs "git switch"
abbr --add gsc "git switch --force-create"
abbr --add gsm "git switch main; and git pull"
abbr --add gv "lazygit --path=$HOME/Documents/Obsidian/Vault/"

# workstuff
abbr --add c claude
abbr --add cc "claude --continue"
abbr --add cs claude-squad
abbr --add http xh
abbr --add https xhs
abbr --add lzd lazydocker
abbr --add o "op run --"
abbr --add plan "terraform plan -out=tfplan | bat"
abbr --add tf terraform

# Shell In Abbreviations
abbr --add tp "mosh piper.bunni.biz -- fish --command tm"
abbr --add tw "mosh webby.bunni.biz -- fish --command tm"

# Brewpaths
if type -q brew
    brew shellenv | source
    set -x HOMEBREW_NO_ENV_HINTS 1
    set -x HOMEBREW_BUNDLE_FILE ~/.config/Brewfile

    ## brew --prefix is way too slow in 4.0 so hardcode
    function _brew_prefix
        printf "$HOMEBREW_PREFIX/opt/$1"
    end

    ## Brew overlays
    set -l apps whois curl libpq
    for app in $apps
        fish_add_path "(_brew_prefix app)/bin"
    end
end

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

## Convenience Functions
function add_path_if_exists
    if test -d "$argv"
        fish_add_path "$argv"
    end
end

function remove_path_if_exists
    set -x PATH (string match -rv "$argv[1]" $PATH)
end

function command_exists
    command --query "$argv"
end


## Putting paths even in non-interactive shells makes Apps Happy™
# Reverse Order is very important

add_path_if_exists /usr/local/bin
add_path_if_exists /opt/homebrew/bin
add_path_if_exists /home/linuxbrew/.linuxbrew/bin

add_path_if_exists ~/go
add_path_if_exists ~/go/bin
add_path_if_exists ~/.cargo/bin
add_path_if_exists ~/.local/bin
add_path_if_exists ~/Applications/
add_path_if_exists ~/bin

# Mosh Server settings are needed at init
# make `killall -USR1 mosh-server` only kill sessions disconected for X seconds
set -x MOSH_SERVER_SIGNAL_TMOUT 60
# Clean up any session that has not been connected to in 30 days
set -x MOSH_SERVER_NETWORK_TMOUT 2592000

# wayland
if test (uname) = Linux
    set -x ELECTRON_OZONE_PLATFORM_HINT=auto
end

# Always utf-8
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x XDG_CONFIG_HOME ~/.config

# Putting this in non-interactive makes Apps use 1Password
# The setting is exported instead of in ssh/config so I can have the test and fallback if this isn't set up
test -S ~/.1password/agent.sock; and set -x SSH_AUTH_SOCK ~/.1password/agent.sock

if status is-interactive
    # Commands to run in interactive sessions can go here

    #
    ## Paths
    #

    # Brewpaths
    if command_exists brew
        brew shellenv | source
        set -x HOMEBREW_NO_ENV_HINTS 1

        ## brew --prefix is way too slow in 4.0 so hardcode
        function _brew_prefix
            printf "$HOMEBREW_PREFIX/opt/$1"
        end

        ## Brew overlays
        set -l apps openssh whois curl libpq
        for app in $apps
            add_path_if_exists "(_brew_prefix app)/bin"
        end
    end

    # Homeshick
    if test -f ~/.homesick/repos/homeshick/homeshick.fish
        source ~/.homesick/repos/homeshick/homeshick.fish
        source ~/.homesick/repos/homeshick/completions/homeshick.fish
        abbr --add hcd homeshick cd
        abbr --add htrack homeshick track
    end

    # asdf-vm
    if test -f ~/.asdf/asdf.fish
        source ~/.asdf/asdf.fish

        if test ! -f ~/.config/fish/completions/asdf.fish
            mkdir -p ~/.config/fish/completions
            ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
        end

        set -x ASDF_GOLANG_MOD_VERSION_ENABLED false
        set -e RUBY_CONFIGURE_OPTS
    end

    # DirENV
    if command_exists direnv
        direnv hook fish | source
        alias tmux "direnv exec / tmux"
    end

    # Wezterm
    add_path_if_exists "$WEZTERM_EXECUTABLE_DIR"

    # Generic overlays
    if command_exists nvim
        set -x EDITOR nvim
    else
        set -x EDITOR vi
    end

    if command_exists eza
        alias ls=eza
        alias la="eza -a"
        alias ll="eza -l"
        alias lla="eza -la"
        alias tree="eza --tree"
    end

    if command_exists fzf
        fzf --fish | source
        set -x FZF_DEFAULT_COMMAND 'fd --follow --hidden --type f'
        set -x FZF_CTRL_T_COMMAND 'fd --follow --hidden'
        set -x FZF_ALT_C_COMMAND 'fd --follow --hidden --type d'

        if test -n "$TMUX"
            set -x FZF_TMUX_OPTS '-p80%,60%'
        end
    end

    if command_exists zoxide
        zoxide init fish | source
    end

    #
    ## Aliases
    #
    abbr --add yeet sudo paru -Rcs
    abbr --add yoink sudo paru -S --needed
    abbr --add squish paru -Qqe

    abbr --add ce chef exec
    abbr --add cet chef exec thor
    abbr --add cek chef exec knife

    abbr --add cl clear

    abbr --add g git
    abbr --add G git

    abbr --add lg lazygit
    abbr --add ld lazydocker

    abbr --add gv lazygit --path="$HOME/Documents/Obsidian/Vault/"

    abbr --add tm tmux new-session -A -c ~
    abbr --add tp mosh piper.local -- tmux new-session -A -c ~
    abbr --add tc mosh catra.local -- tmux new-session -A -c ~
    abbr --add tw mosh webby.local -- tmux new-session -A -c ~

    abbr --add venv python3 -m venv
    abbr --add mkvenv python3 -m venv venv
    abbr --add activate source venv/bin/activate

    #
    ## Prompt
    #
    set fish_color_user green
    set fish_color_host green
    set fish_color_cwd green
    set __fish_git_prompt_color magenta
    set __fish_git_prompt_show_informative_status yes
    set __fish_git_prompt_use_informative_chars yes
    set __fish_git_prompt_showuntrackedfiles yes
    set __fish_git_prompt_showdirtystate yes

    #
    ## Fish
    #
    set -g fish_greeting
end

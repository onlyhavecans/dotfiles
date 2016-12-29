# D.O.S. dotfiles #
Yet another dotfiles repo.

## Notes ##
I use chef-client --local-mode to deploy all of this. See the updater.sh script.

This works both on OS X and FreeBSD. I maintain these very frequently to work on both since I use both interchangably daily and want everything to act the same.

## Apps ##
### fish ###
* fish-shell is the shell to have!
* I use a lot of command aliases as functions.

### vim ###
* Currently I use neovim but I try to make sure the config stays working in vim, even though some plugins won't load
* The configuration is a bit overdone but very powerful
    * there is a LOT of language plugins since I write in Python/Ruby/Go/Elixir/ect
* I use vim-plug currently
* to use the the_silver_searcher stuff :Ack in vim

### gnupg ###
I've pulled my config and added it to a special secrets dir that is not shared.
I recommend using the riseup.net setup

### Vagrant ###
I use vagrant a LOT in kitchen runs. I have a global vagrant file that will force install some plugins.
It also sets up several layers of caching since I work remote

### homebrew ###
* My apps are managed by chef
* You can add hombe-brew cask but I removed it see [https://github.com/chef-cookbooks/homebrew#homebrew_cask] for more details

### git ###
* The global gitignore is mac/python/ruby/chef/go/ect oriented

### tmux ###
* live by tmux
* die by tmux
* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* Instead of a powerline I use tmux plugins use ^a-I to install
* the tmux builders are set up as fish functions
  * work/school/muck/ect


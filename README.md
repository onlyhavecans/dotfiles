# D.O.S. dotfiles #
Yet another dotfiles repo.

## Notes ##
I use chef-client --local-mode to deploy all of this. See the updater.sh script.

This works both on OS X and FreeBSD. I maintain these very frequently to work on both since I use both interchangably daily and want everything to act the same.

## Apps ##
### pour/four ###
pour and four are "Update all my things" fish functions. pour for macOS and four for FreeBSD

repour re-installs everything with homebrew after a major OS upgrade.

### fish ###
I have a bit of a crazy fish setup. I break out everything into a config.d. Most of it is super personal to me but could be useful. I try to avoid universal variables and go for setting things in the config.fish since I want this to be portable amongst all my machines.

Also notice the immense amount of functions.

### vim ###
* Currently I use neovim
* The configuration is a bit overdone but very powerful
    * there is a LOT of language plugins since I write in far too many languages
* I use vim-plug currently
* I abuse rupgrep a lot

### gnupg ###
I've pulled my config and added it to a special secrets dir that is not shared.
I recommend using the riseup.net setup

### Vagrant ###
I use vagrant a LOT in kitchen runs. I have a global vagrant file that will force install some plugins.
It also sets up several layers of caching since I work remote

### homebrew ###
* My apps are managed by chef

### git ###
* The global gitignore is mac/python/ruby/chef/go/ect oriented
* my githooks setup is stolen from https://github.com/pivotal-cf/git-hooks-core which is awesome and you should use it too

### tmux ###
* live by tmux
* die by tmux
* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* Instead of a powerline I use tmux plugins use ^a-I to install

### direnv ###
I use direnv.net *everywhere*. I have a few standard functions I use to help me out. Most of it around chef and ruby-install

### rust ###
Rust is one of the few things *not* set up by the cookbook. I just have a `rust-init.sh` to set it up and occasionally refresh. I may pull this into the cookbook sune but I'm unsure as it's hard to make properly idempotent and the installs are long running

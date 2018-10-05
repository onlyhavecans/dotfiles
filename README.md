# D.O.S. dotfiles #
Yet another dotfiles repo.

## Notes ##
It's time for some [homeshick](https://github.com/andsens/homeshick).

I use the shell version over the ruby version because less ruby reliance and also I like the way it links better.

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

### tmux ###
* live by tmux
* die by tmux
* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* Instead of a powerline I use tmux plugins use ^a-I to install

### gnupg ###
I've pulled my config and added it to a special secrets dir that is not shared.
I recommend using the riseup.net setup

### homebrew ###
* My apps are managed by chef

### git ###
* The global gitignore is mac/python/ruby/chef/go/ect oriented

### direnv ###
I use direnv.net *everywhere*. I have a few standard functions I use to help me out. Most of it around chef and ruby-install

### rust ###
Rust is one of the few things *not* set up by the cookbook. I just have a `rust-init.sh` to set it up and occasionally refresh.

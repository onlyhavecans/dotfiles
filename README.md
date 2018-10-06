# D.O.S. dotfiles #

Yet Another Dotfiles Repo.

## Notes ##

I've switched to using [homeshick](https://github.com/andsens/homeshick).

I use the shell version over the ruby version because less ruby reliance and also I like the way it links better.

## Apps ##

### fish ###

I have a bit of a crazy fish setup.
I break out everything into a config.d.
Most of it is personal to me but could be useful.
I try to avoid universal variables and go for setting things in the config.fish since I want this to be portable amongst all my machines.

**Check out the immense amount of functions**
I replace a lot of commands and scripts with functions

### neovim ###

* I use neovim instead of vim
* The configuration is stripped down to just what I like, but still far from vanilla
* there is a LOT of language plugins since I write in far too many languages
* I use vim-plug currently to manage plugins
* There is a few functions at the end for cleaning things up

### tmux ###

* live by tmux
* die by tmux
* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* Instead of a powerline I use tmux plugins use ^a-I to install

### gnupg ###

I recommend using the riseup.net setup, but last I checked it's a bit out of date.

Mine is a ported version of this, I use gpg in a lot of places so I need the agent to work in CLI & gui

### git ###

* The global gitignore is mac/python/ruby/chef/go/ect oriented
* The main config is set up with lots of alias & uses gpg signing by default

### ssh ###

I included my ssh_config because I think it can be useful to others. I have ssh fairly locked down.

The keys directory setup means for every host or set of hosts I log into I generate a different key!
This means loosing a single key to a single system is not a hige swatch of revokes.
However regenning all the keys for a yearly rotation or new machine is slightly annoying so I have a fish function called keygen which makes this easier.

### direnv ###

I use direnv.net *everywhere*.
I have a few standard functions I use to help me out.
Most of it around chef and ruby-install

### rust ###

Rust is one of the few things *not* set up by the cookbook.
Instead I have a fish function called `init_rust` which installs & sets up rust

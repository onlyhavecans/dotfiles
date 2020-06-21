# D.O.S. dotfiles

Yet Another Dotfiles Repo.

## Notes

This uses [homeshick](https://github.com/andsens/homeshick).

I mostly work on macOS but I try to keep this workable on my FreeBSD machines, so there may be some splits

## Apps

### fish

Even thought fish is great out of box I set up a lot of various path and environment changes.
I try to avoid universal variables and go for setting things in the config.fish since I want this to be portable amongst all my machines.

**Check out the immense amount of functions**

I replace a lot of commands and scripts with functions. I use this instead of making little shell apps for all my various helper scripts.

### neovim

* I use neovim instead of vim
* My setup is fairly bespoke
* there is a LOT of language plugins since I write in far too many languages
* I use vim-plug currently to manage plugins
* There is a few functions at the end for cleaning things up

### tmux

* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* Instead of a powerline I use tmux plugins use ^a-I to install

### gnupg

* I recommend using the riseup.net setup, but last I checked it's a bit out of date.
* Mine is a ported version of this, I use gpg in a lot of places so I need the agent to work in CLI & gui

### git

* The global gitignore is mac/python/ruby/chef/go/ect oriented
* The main config is set up with lots of alias & uses gpg signing by default

### ssh

I included my ssh_config because I think it can be useful to others. I have ssh fairly locked down.

The keys directory setup means for every host or set of hosts I log into I generate a different key!
This means loosing a single key to a single system is not a large swath of revokes.
However regenning all the keys for a yearly rotation or new machine is slightly annoying so I have a fish function called keygen which makes this easier.

### direnv

I use direnv frequently
I have a few standard functions I use to help me out.

### asdf-vm

I've moved to using asdf-vm to manage most of my languge versions since I am quite polyglot and it's nice to have a single manager for that.

### rust

I have a fish function called `init_rust` which installs & sets up rust

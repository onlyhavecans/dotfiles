# D.O.S. dotfiles

Yet Another Dotfiles Repo.

This uses [homeshick](https://github.com/andsens/homeshick).

I mostly work on macOS but I try to keep this workable on my FreeBSD machines, so there may be some splits

Overall I am trying not to have too bespoke of a setup but there is a lot of initialization and configuration for access to dev tooling

## Setup

### Mac

Start by installing [homebrew](https://brew.sh/)
then curlbash the inti-macos.sh script!

## Apps

### zsh

I try to keep my shell config sparse and rely on a lot of small commands installed in ~/bin
This is slightly less efficient but more extensible

I also use FZF to get around a lot since I miss fish's completion

### homebrew

I use a Brewfile to manage my packages and keep it consistent on macOS
Instead of running brew upgrade manually I run my `pour` function which does a lot of dep work.

### tmux

* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* I use tmux plug-ins use ^a-I to install

### gnupg

* I recommend using the riseup.net setup, but last I checked it's a bit out of date.
* Mine is a ported version of this, I use gpg in a lot of places so I need the agent to work in CLI & gui

### git

* The global gitignore is mac/python/ruby/chef/go/ect oriented
* The main config is set up with lots of alias & uses gpg signing by default

### ssh

I included my ssh config because I think it can be useful to others.

The keys directory setup means for every host or set of hosts I log into I generate a different key!
This means loosing a single key to a single system is not a large swath of revokes.
However regenerating all the keys for a yearly rotation or new machine is slightly annoying so I have a fish function called keygen which makes this easier.

### direnv

I use direnv frequently
I have a few standard functions I use to help me out.

### asdf-vm

Uses asdf-vm to manage most of my language versions since I am quite polyglot.
I have a global .tool-versions but generally don't store that in dotfiles as `pour` manages it.
There is also a lot of .default packages to keep support open

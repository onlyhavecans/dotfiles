# D.O.S. dotfiles

Yet Another Dotfiles Repo.

This uses [homeshick](https://github.com/andsens/homeshick).

These are designed to work on macOS, Mint, Arch, and NixOS... all at the same time currently.

Overall I am trying not to have too bespoke of a setup but there is a lot of initialization and configuration for access to dev tooling

## Setup

### Linux


### Mac

Start by installing [homebrew](https://brew.sh/)
then curlbash the init.sh script!

## Apps

### fish-shell

My primary shell. I try to keep it pretty lean. There is  a few small functions but overall I push most shortcuts and tooling into ~/bin

### homebrew

I use a Brewfile to manage my packages and keep it consistent on everything 
Instead of running brew upgrade manually I run my `pour` function which does a lot of dep work.

### tmux

- I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
- I use tmux plug-ins use ^a-I to install

### git

- The global gitignore is mac/python/ruby/chef/go/ect oriented
- The main config is set up with lots of alias & uses gpg signing by default
- instead of gh or hub I now use a custom git_open script I found on the sublime merge forum and modified

### ssh

I included my ssh config because I think it can be useful to others.

### direnv

I use direnv frequently
I have a few standard functions I use to help me out.

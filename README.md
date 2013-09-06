# tBunnyMan dotfiles #
Yet another dotfiles repo.

## Notes ##
I stole my Rakefile from https://github.com/holman/dotfiles

## Apps ##
### zsh ###
* I now use oh-my-zsh as a base, but it's installed separately
* zsh/first and zsh/last are used to order loading
    * First is for path init and global shell env
    * Last is for things that might/will stomp on defaults and banners

### muck ###
* I am switching over to tt++ since tf has fallen behind times
* It's heavily in work since the highlighting works differently
* **tiny.world is ignored** You need one of these
* The configuration here is social muck oriented

### OpenBox ###
* The files for openox will not link properly.
* But it is what I use for work so there is some useful scripts

### vim ###
* The configuration is python oriented
* All bundles are git submodules so after you check out;
    * `git submodule init && git submodule update`

### weechat ###
* **irc.conf is ignored**
* This config isn't too special but it has some nice plugins

### git ###
* The global gitignore is mac/python oriented
* **gitconfig is ignored**

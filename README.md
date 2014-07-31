# tBunnyMan dotfiles #
Yet another dotfiles repo.

## Notes ##
I stole my Rakefile from https://github.com/holman/dotfiles

## Apps ##
### Shell ###
* I now use Fish. my Rakefile can't really handle the .conf layout so.... it's coming

### vim ###
* The configuration is python oriented
* I finally broke the submodule trap with vundle.
  * Rake the dotfiles
  * git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  * vim +BundleInstall +qall

### irssi ###
* Hmmm I need to move this back to dotfiles too

### git ###
* The global gitignore is mac/python oriented
* **gitconfig is ignored**

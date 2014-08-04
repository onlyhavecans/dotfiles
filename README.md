# tBunnyMan dotfiles #
Yet another dotfiles repo.

## Notes ##
I use chef-client --local-mode to deply all this. THis still new and rickety, expectially since I haven't refacotred EVERYTHING yet

## Apps ##
### Shell ###
* fish-shell is the shell to have!

### vim ###
* The configuration is python oriented with some ruby
    * This is where I spend most of my day and I think it shows
* I finally broke the submodule trap with vundle.
  * Sadly chef won't fully bootsrtap this because of vim errors on inital load 
  * to initalize new plugins: vim +PluginInstall +qall 
  * to plugins: vim +PluginUpdate +qall 

### homebrew ###
* My apps are managed by chef, I haven't gotten too deep into cask yet

### git ###
* The global gitignore is mac/python oriented

### tmux ###
* live by tmux
* die by tmux

### irssi ###
* Hmmm I need to move this back to dotfiles too


# D.O.S. dotfiles #
Yet another dotfiles repo.

## Notes ##
I use chef-client --local-mode to deploy all of this.

## Apps ##
### fish ###
* fish-shell is the shell to have!
* I use a lot of command aliases as functions.

### vim ###
* The configuration is a bit overdone but very powerful
* I finally broke the submodule trap with vundle.
  * to initalize new plugins: vim +PluginInstall +qall
  * to plugins: vim +PluginUpdate +qall
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
* The global gitignore is mac/python/ruby/chef oriented

### tmux ###
* live by tmux
* die by tmux
* I have it set up so that you can navigate through tmux and vim seamlessly using C-hjlk
* Instead of a powerline I use tmux plugins use ^a-I to install
* the tmux builders are set up as fish functions
  * work/school/muck/ect


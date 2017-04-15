function pour --description "Update all my homebrew stuff that isn't pinned"
  ## Don't look at all the cheef-dk stuff
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  brew upgrade
  status_message brew prune since chef-dk always makes broken synlinks
  brew prune
  status_message pregenerate fuck command to save shell launch time
  if test -x /usr/local/bin/thefuck
    thefuck --alias | source
    funcsave fuck
  end
  status_message pregenerate chef-dk to save shell launch time
  if test -x /opt/chefdk/bin/chef
    /opt/chefdk/bin/chef shell-init fish > {$HOME}/.chefdk.fish
    set -lx FIND '"/usr/local/bin" "/usr/local/sbin" "/bin" "/sbin" "/usr/bin" "/usr/sbin"'
    set -lx REPLACE '$PATH'
    ruby -p -i -e "gsub(ENV['FIND'], ENV['REPLACE'])" {$HOME}/.chefdk.fish
  end
  status_message doctor brew
  brew doctor
  vim +PlugUpgrade +qall
  vim +PlugUpdate
end

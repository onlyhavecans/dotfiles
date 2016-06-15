function repour --description "recompile all of pour"
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  brew update
  for count in 1 2
    for pkg in (brew list)
      brew reinstall $pkg
    end
  end
  brew cleanup -s
  brew doctor
  vim +PluginUpdate +qall
end

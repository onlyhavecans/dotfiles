function repour --description "recompile all of brew"
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  xcode-select --install
  brew update
  brew bundle install --global
  brew upgrade
  for count in 1 2
    brew list --formula | xargs brew reinstall
  end
  brew cleanup -s
end

function repour --description "recompile all of pour"
  set -lx PATH /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin
  xcode-select --install
  sudo xcodebuild -license accept
  brew update
  brew upgrade
  for count in 1 2
    brew list | xargs brew reinstall
  end
  brew cleanup -s
  pour
end

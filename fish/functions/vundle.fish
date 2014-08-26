function vundle --description "Vundle commands"
  switch $argv
    case install
      vim +PluginInstall +qall
    case update
      vim +PluginUpdate +qall
    case clean
      vim +PluginClean +qall
    case '*'
      echo "No No No No! Try again"
    end
  end

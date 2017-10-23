function fish_greeting
  if test -e "$HOME/Code/fortune"
    cowsay -f $HOME/Code/fortune/cows/squirrel.cow  (fortune -s -n 600 $HOME/Code/fortune/fortune/showerthoughts)
  end
end

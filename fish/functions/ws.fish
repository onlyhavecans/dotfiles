function ws --description "Annoy my coworkers"
  whitespace $argv | reattach-to-user-namespace pbcopy
end

function key --description "Load my key for the year and that machine"
  ssh-add -t 12h ~/.ssh/*-(date +%Y)_rsa
end

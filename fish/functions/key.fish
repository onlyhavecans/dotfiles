function key --description "Load my key for the year"
  ssh-add -t 12h ~/.ssh/*-(date +%Y)_rsa
  ssh-add -t 12h ~/.ssh/*-(date +%Y)_ed25519
end

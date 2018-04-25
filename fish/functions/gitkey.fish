function gitkey --description "Load my git key for IntelliJ editors"
  ssh-add -t 12h ~/.ssh/keys/github.com/git/id_ed25519
end

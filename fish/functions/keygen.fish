function keygen --description "How I am generating keys currently"
  ssh-keygen -t ed25519 -C dos@(hostname)-(date +%Y) -f ~/.ssh/dos@(hostname)-(date +%Y)_ed25519
end

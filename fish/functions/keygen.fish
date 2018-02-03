function keygen --description "How I am generating keys currently"
  ssh-keygen -t ed25519 -C (whoami)@(hostname)-(date +%F) -f ~/.ssh/(whoami)@(hostname)-(date +%Y)_ed25519
  ssh-keygen -t rsa -b 4096 -C (whoami)@(hostname)-(date +%F) -f ~/.ssh/(whoami)@(hostname)-(date +%Y)_rsa
end

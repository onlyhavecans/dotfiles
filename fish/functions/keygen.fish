function keygen --description "How I am generating keys currently"
  ssh-keygen -t ed25519 -C dos@(hostname)-(date -v+1y +%Y) -f ~/.ssh/dos@(hostname)-(date -v+1y +%Y)_ed25519
  ssh-keygen -t rsa -b 4096 -C dos@(hostname)-(date -v+1y +%Y) -f ~/.ssh/dos@(hostname)-(date -v+1y +%Y)_rsa
end

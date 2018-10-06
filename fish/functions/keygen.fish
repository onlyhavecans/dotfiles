function keygen --description "How I am generating keys currently"
  status_message "What hostname is this key for?"
  read -l key_remote

  set -l key_dir "$HOME/.ssh/keys/$key_remote"
  mkdir -p "$key_dir"

  ssh-keygen -t ed25519 -C (whoami)@(hostname)-(date +%F) -f "$key_dir/id_ed25519"
  ssh-keygen -t rsa -b 4096 -C (whoami)@(hostname)-(date +%F) -f "$key_dir/id_rsa"
end

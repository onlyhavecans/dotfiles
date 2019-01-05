function keygen --description "How I am generating keys currently"
  status_message "What hostname is this key for?"
  read -l key_remote

  set -l key_dir "$HOME/.ssh/keys/$key_remote"
  mkdir -p "$key_dir"

  set -l key_rsa "$key_dir/id_rsa"
  set -l key_ed "$key_dir/id_ed25519"

  for old_key in $key_ed $key_rsa $key_ed.pub $key_rsa.pub
    if test -f $old_key
      status_message "Rotating away old key $old_key"
      mv "$old_key" "$old_key-rotated-"(date +%F)
    end
  end

  ssh-keygen -t ed25519 -C (whoami)@(hostname)-(date +%F) -f "$key_ed"
  ssh-keygen -t rsa -b 4096 -C (whoami)@(hostname)-(date +%F) -f "$key_rsa"
end

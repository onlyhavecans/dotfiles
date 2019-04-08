function cleanhost
  if not test 1 -eq (count $argv)
    echo "Only pass one domain name"
    return 1
  end

  ssh-keygen -R $argv
  ssh-keygen -R (dig +short $argv | tail -n 1)
end

function key
  switch $argv
    case bitm
      ssh-add -t 12h ~/.ssh/bitm_rsa
    case slick
      ssh-add -t 12h ~/.ssh/slick-dha_rsa
    case '*'
      echo "Noooooooo"
  end
end

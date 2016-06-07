function skwrlstrap --description "bootstrap swkrl boxes" --argument-names ip nodename sshuser
  if test -z $ip; or test -z $nodename
    echo 'usage; ip node-name ssh-user'
  else
    if test -z $sshuser
      set -l user 'root'
    end

    set -lx chef 'hosted'
    knife bootstrap $ip --node-name $nodename --ssh-user $sshuser --sudo --run-list 'recipe[skwrl_watsky::default]'
  end
end


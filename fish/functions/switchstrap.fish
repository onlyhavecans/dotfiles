function switchstrap --description "A cheap and easy bootstrapper for the yolo generation"
  set -l serv $argv
  set -lx chef switch
  knife bootstrap $serv --ssh-user root --node-name $serv --run-list 'recipe[sd_wrapper::sdlv]'
end

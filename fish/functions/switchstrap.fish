function switchstrap --description "A cheap and easy bootstrapper for the yolo generation"
  set -l serv $argv
  set -lx chef switch
  knife bootstrap $serv.lv.slickdeals.net --ssh-user root --node-name $serv.lv.slickdeals.net --run-list 'recipe[sd_wrapper::sdlv]'
end

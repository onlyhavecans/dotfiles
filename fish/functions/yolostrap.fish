function yolostrap --description "A cheap and easy bootstrapper for the yolo generation"
  set serv $argv
  set -lx chef phx
  knife bootstrap p$serv.slickdeals.net --ssh-user root --node-name $serv.slickdeals.net --run-list 'role[yoloswag]'
end

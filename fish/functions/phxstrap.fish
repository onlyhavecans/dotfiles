function phxstrap --description "A cheap and easy bootstrapper for phx"
  set -l serv $argv
  set -lx chef phx
  knife bootstrap p$serv.slickdeals.net --ssh-user root --node-name $serv.slickdeals.net --run-list 'role[phx]'
end

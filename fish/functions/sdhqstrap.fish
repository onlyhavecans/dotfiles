function sdhqstrap --description "A cheap and easy bootstrapper for the yolo generation"
  set serv $argv
  knife block sdhq
  knife bootstrap $serv --ssh-user root --node-name $serv --run-list 'role[sdhq]'
end

function chefuser --description "Update chef user databak from files"
  set -l sites switch phx sdhq
  for site in $sites
    set -lx chef $site
    status_message "Uploading $site databag users from file $argv"
    knife data_bag from file users $argv
  end
end

function berkit --description "Berks deploy to all sites"
  status_message "Running a berks update"
  berks update
  set -l sites phx sdhq
  for site in $sites
    set -lx chef $site
    status_message "Uploading site $site"
    berks upload --no-ssl-verify
  end
end

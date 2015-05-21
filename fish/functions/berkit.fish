function berkit --description "Berks deploy to all sites"
  echo "~ Running a berks update"
  berks update
  for site in "sdhq" "phx"
    set -lx chef $site
    echo "~ Uploading site $site"
    berks upload --no-ssl-verify
  end
end

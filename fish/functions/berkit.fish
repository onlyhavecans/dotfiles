function berkit --description "Berks deploy to all sites"
  berks update
  for site in "sdhq" "phx"
    set -lx $site
    berks upload --no-ssl-verify
  end
end

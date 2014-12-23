function berkbiz --description "Berks deploy to bbiz"
  berks update
  for site in "bbiz"
    knife block $site
    berks upload --no-ssl-verify
  end
end

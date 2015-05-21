function berkbiz --description "Berks deploy to bbiz"
  berks update
  set -lx chef bbiz
  berks upload --no-ssl-verify
end

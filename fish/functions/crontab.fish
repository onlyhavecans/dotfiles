function crontab --description "fix a dumb bug"
  set -lx EDITOR vim
  /usr/bin/crontab $argv
end

# vi: ft=fish

function crontab --description "fix a dumb bug"
  set EDITOR /usr/local/bin/vim
  /usr/bin/crontab $argv
end

# vi: ft=fish

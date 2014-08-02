# Fix a dumb bug
function crontab
  set EDITOR /usr/local/bin/vim 
  /usr/bin/crontab $argv
end

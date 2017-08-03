function standup --description "Show all the work I've done last week"
  set -l old_dir (pwd)
  cd ~/Code
  git standup -m 5 -d 7
  cd $old_dir
end

function standup --description "Show all the work I've done last week"
  set -l old_dir (pwd)
  cd ~/Code/dnsimple/ops
  git standup -f -m 5 -d 8
  cd $old_dir
end

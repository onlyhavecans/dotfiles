function addpath
  if not test 1 -eq (count $argv)
    echo "Only one path at a time plz"
  else
    contains -- $argv $fish_user_paths
      or set -U fish_user_paths $fish_user_paths $argv
    echo "Updated PATH: $PATH"
  end
end

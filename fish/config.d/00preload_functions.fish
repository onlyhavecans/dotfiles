function prepend_path
  if not test 1 -eq (count $argv)
    echo "only one path at a time"
    return 1
  end

  set -l my_path $argv
  contains -- $my_path $PATH
    or set -x PATH $my_path $PATH
end

function append_path
  if not test 1 -eq (count $argv)
    echo "only one path at a time"
    return 1
  end

  set -l my_path $argv
  contains -- $my_path $PATH
    or set -x PATH $PATH $my_path
end

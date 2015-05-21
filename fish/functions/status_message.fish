function status_message --description "Print message in bright color to be more noticeable"
  set_color red
  echo "~ $argv"
  set_color normal
end

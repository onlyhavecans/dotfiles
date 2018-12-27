function update_vagrant_boxes --description "Update all my boxes (often just bentos)"
  for box in (vagrant box outdated --global | tr -d "*'" | awk '/outdated/ {print $1}')
    vagrant box add --clean --provider $VAGRANT_DEFAULT_PROVIDER $box
  end

  vagrant box prune --force
end

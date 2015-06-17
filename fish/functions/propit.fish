function propit --description "Reenable propupd for everyone"
  set -l sites phx sdhq
  for i in $sites
    set -lx chef $i
    status_message "Clearing propupd flag on all servers in $i"
    knife exec -E 'nodes.all { |n| n.normal_attrs.delete("propupd_complete"); n.save() }'
  end
end

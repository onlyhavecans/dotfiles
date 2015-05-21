function propit --description "Reenable propupd for everyone"
  set sites bbiz phx sdhq
  for i in $sites
    set -lx chef $i
    knife exec -E 'nodes.all { |n| n.normal_attrs.delete("propupd_complete"); n.save() }'
  end
end

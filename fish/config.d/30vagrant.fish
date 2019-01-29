# I sometimes use vmware
if test -x '/Applications/VMware\ Fusion.app/Contents/Library/vmrun'
  set -x VAGRANT_DEFAULT_PROVIDER vmware_fusion
  abbr --add vmrun '/Applications/VMware\ Fusion.app/Contents/Library/vmrun'
else
  set -x VAGRANT_DEFAULT_PROVIDER virtualbox
end

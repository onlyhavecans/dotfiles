# Defined in /var/folders/c4/m5qm98cd4wnd65qznsr3cn6w0000gp/T//fish.Tm0oo7/standup.fish @ line 2
function standup
	set -l old_dir (pwd)
	cd ~/Code
  git standup -m 5 -d 7
  cd $old_dir
end

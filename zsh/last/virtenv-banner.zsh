### Present all availible VirtENVs as a banner

##Bar Drawer
function bar () {
	for (( i = 0; i < ${COLUMNS}; i++ )); do
		echo -n '='
	done
	echo 
}

set -A virtenvs `workon`
bar
echo "Installed Enviroment Wrappers;"
echo ${fg[red]}$virtenvs${fg[default]}
echo "Use syspip to edit system packages"
bar

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
echo "Disable PIP lock; 'export PIP_REQUIRE_VIRTUALENV=false'"
bar

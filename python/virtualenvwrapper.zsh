## Virtual ENV Wrapper

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python #Use system Python
if [[ -f '/usr/bin/virtualenv' ]]; then
	export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv #(some linuxes stuff this here)
else
	export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
fi
export WORKON_HOME=~/Virtualenvs #Where my enviroments go
export PROJECT_HOME=~/PyProjects #Default Project basebath
export PIP_VIRTUALENV_BASE=~/Virtualenvs #How PIP uses wrapper
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_REQUIRE_VIRTUALENV=true #PIP Only Allows installs in to VirtualEnv
export PIP_RESPECT_VIRTUALENV=true #PIP always uses virtual enviroments
if [[ -f 'source /etc/bash_completion.d/virtualenvwrapper' ]]; then
	source /etc/bash_completion.d/virtualenvwrapper #Darn Debian
elif [[ -f '/usr/local/bin/virtualenvwrapper.sh' ]]; then
	source /usr/local/bin/virtualenvwrapper.sh #The normal
else
	echo "Can't find virtualenv wrapper!!! Bail!!!"
fi

##Bar Drawer
function bar () {
	for (( i = 0; i < ${COLUMNS}; i++ )); do
		echo -n '='
	done
	echo 
}

autoload colors && colors
### I like seeing my availible enviroments
set -A virtenvs `workon`
bar
echo "Installed Enviroment Wrappers; Change with 'workon'"
echo ${fg[red]}$virtenvs${fg[default]}
echo "Disable PIP lock with 'export PIP_REQUIRE_VIRTUALENV=false'"
bar
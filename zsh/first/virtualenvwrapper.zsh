## VirtualENV for all!
export WORKON_HOME=$HOME/Virtualenvs
export PROJECT_HOME=$HOME/Code
export PIP_VIRTUALENV_BASE=$HOME/Virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
 }

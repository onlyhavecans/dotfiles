## VirtualENV for all!
export WORKON_HOME=$HOME/Virtualenvs
export PROJECT_HOME=$HOME/Code
export PIP_VIRTUALENV_BASE=$HOME/Virtualenvs
export PIP_RESPECT_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

syspip(){
   PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip "$@"
 }

syspip3(){
   PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip3 "$@"
 }

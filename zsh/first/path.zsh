#Path weird!

#Also grab the system wide apps
if [[ -d /Applications ]]; then
	PATH=/Applications:${PATH}
fi

#PSQL.app
if [[ -d /Applications/Postgres.app/Contents/MacOS/bin ]]; then
  PATH=/Applications/Postgres.app/Contents/MacOS/bin:${PATH}
fi

if [[ -d $HOME/pycharm/bin ]]; then
  PATH=$HOME/pycharm/bin:${PATH}
fi

if [[ -d $HOME/navicat_premium ]]; then
  PATH=$HOME/navicat_premium:${PATH}
fi

# High Priotity /usr/local
if [[ -d '/usr/local/bin' ]]; then
	PATH="/usr/local/bin:${PATH}"
fi

if [[ -d '/usr/local/sbin' ]]; then
	PATH="/usr/local/sbin:${PATH}"
fi

#User Applications
if [[ -d ${HOME}/Applications ]]; then
	PATH=${HOME}/Applications:${PATH}
fi

export PATH

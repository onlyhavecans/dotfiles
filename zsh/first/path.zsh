#Path weird!

#Also grab the system wide apps
if [[ -d /Applications ]]; then
	PATH=/Applications:${PATH}
fi

# High Priotity /usr/local
if [[ -d '/usr/local/bin' ]]; then
	PATH="/usr/local/bin:${PATH}"
fi

#User Applications
if [[ -d ${HOME}/Applications ]]; then
	PATH=${HOME}/Applications:${PATH}
fi

# Mac Python 3.2
if [[ -d '/Library/Frameworks/Python.framework/Versions/3.2/bin' ]]; then
	PATH="/Library/Frameworks/Python.framework/Versions/3.2/bin:${PATH}"
fi

export PATH

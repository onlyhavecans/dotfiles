#My Complex editor
if [[ -f  '/Applications/TextMate.app/Contents/SharedSupport/Support/bin/mate' ]]; then
	EDITOR='/Applications/TextMate.app/Contents/SharedSupport/Support/bin/mate -wrd'
elif [[ -f `which mate` ]]; then
	EDITOR="`which mate` -wrd"
elif [[ -f `which vim` ]]; then	
	EDITOR=`which vim`
else
	EDITOR='/bin/vi'
fi
export EDITOR
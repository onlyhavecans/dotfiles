#My Complex editor
if [[ -f  '/Applications/mvim' ]]; then
	EDITOR='/Applications/mvim -f'
elif [[ -f `which mvim` ]]; then
	EDITOR="`which mvim` -f"
elif [[ -f `which vim` ]]; then
	EDITOR=`which vim`
else
	EDITOR='/bin/vi'
fi
export EDITOR

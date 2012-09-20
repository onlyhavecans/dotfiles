#My Complex editor
if [[ -f  $HOME/Applications/mvim ]]; then
	EDITOR="$HOME/Applications/mvim -f"
elif [[ -f `which mvim` ]]; then
	EDITOR="`which mvim` -f"
elif [[ -f /usr/local/bin/vim ]]; then
  EDITOR=/usr/local/bin/vim
elif [[ -f `which vim` ]]; then
	EDITOR=`which vim`
else
	EDITOR='/bin/vi'
fi
export EDITOR

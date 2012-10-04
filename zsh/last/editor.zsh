#My Complex editor
if [[ -f /usr/local/bin/vim ]]; then
  EDITOR=/usr/local/bin/vim
elif [[ -f `which vim` ]]; then
	EDITOR=`which vim`
else
	EDITOR='/bin/vi'
fi
export EDITOR

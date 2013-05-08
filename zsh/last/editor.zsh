#My Complex editor
if [[ -f /usr/local/bin/emacs ]]; then
  EDITOR=/usr/local/bin/emacs
elif [[ -f `which emacs` ]]; then
	EDITOR=`which emacs`
else
	EDITOR='/bin/vi'
fi
export EDITOR

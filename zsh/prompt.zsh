autoload colors && colors

autoload -Uz promptinit
promptinit
setopt prompt_subst
prompt adam2 cyan green cyan magenta

current_virtenv(){
	if [[ $VIRTUAL_ENV == "" ]]; then
		echo none
	else
		echo `basename \"$VIRTUAL_ENV\"`
	fi
}
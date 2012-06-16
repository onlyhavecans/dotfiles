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

RPROMPT="%{${fg_bold[cyan]}%}(virtenv: %{${fg[magenta]}%}$(current_virtenv)%{${fg_bold[cyan]}%})%{${reset_color}%} $RPROMPT"
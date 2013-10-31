#Why did I write it out like some mo? becasue I want it to be readable when I go to change it in 8 months and have forgot all the escape characters
autoload -U colors && colors

function _prompt_end() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$2}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$1}"
    echo -n "%{$bg$fg%}"
    echo -n " "
    echo -n "%{%k%f%}"
}

function _prompt_char() {
    echo -n "%{%B%}"
    echo -n "%{%F{white}%}"
    echo -n '無'
    echo -n "%{%f%}"
    echo -n "%{%b%}"
}

function _prompt_userhost() {
    echo -n "%{%K{black}%F{default}%}"
    echo -n "%n"
    echo -n "@"
    echo -n "%M"
    echo -n "%{%f%k%}"
    _prompt_end black blue
}

function _prompt_path() {
    echo -n "%{%K{blue}%F{black}%}"
    echo -n "%~"
    echo -n "%{%k%f%}"
    _prompt_end blue default
}


setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

PROMPT=$'$(_prompt_userhost)$(_prompt_path)$(vcs_info_wrapper)
$(_prompt_char)'

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch --bold magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles --bold normal
set -g __fish_git_prompt_color_cleanstate --bold green

set -g fish_color_user cyan
set -g fish_color_host 9C9C9C
set -g fish_color_error red
set -g fish_color_cwd yellow
set -g fish_color_chef blue

function fish_prompt --description 'Write out the prompt'

  set -l last_status $status

  if not test $last_status -eq 0
    set_color $fish_color_error
    printf 'fish: Prior command failed; [%s] \n' $last_status
    set_color normal
  end


  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  #user@hostname
  set_color $fish_color_user
  echo -n $USER
  set_color $fish_color_host
  printf '@%s ' $__fish_prompt_hostname
  set_color normal

  #CHEF
  if set -q chef
    printf '🍴 '
    set_color $fish_color_chef
    printf '%s ' $chef
    set_color normal
  end


  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  #GIT
  printf '%s> ' (__fish_git_prompt)

end

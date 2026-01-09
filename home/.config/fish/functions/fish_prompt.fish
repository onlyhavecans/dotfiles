function fish_prompt
    set -l last_status $status

    # Icons (Material Design nerdfont)
    set -l icon_dir \uf4d4  # folder
    set -l icon_git \ue702  # git branch

    # Top line: [HH:MM:SS] hostname  dir  git
    set_color yellow
    echo -n "["(date +%H:%M:%S)"] "
    set_color green
    echo -n (hostname)" $icon_dir "(prompt_pwd)
    set_color magenta
    echo -n (fish_git_prompt " $icon_git %s")
    echo

    # Bottom line: status chevron
    if test $last_status -eq 0
        set_color blue
    else
        set_color red
        echo -n "$last_status"
    end
    echo -n "❯ "
    set_color normal
end

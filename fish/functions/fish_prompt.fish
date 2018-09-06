function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color cyan)(prompt_pwd) (set_color 55cdfc)'❯'(set_color f7a8b8)'❯'(set_color ffffff)'❯'(set_color f7a8b8)'❯'(set_color 55cdfc)'❯ '
end

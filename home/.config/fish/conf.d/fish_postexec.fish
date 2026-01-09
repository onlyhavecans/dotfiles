function fish_postexec --on-event fish_postexec
    set -l last_status $status
    set -l last_pipestatus $pipestatus
    set -l duration $CMD_DURATION
    set -l cmd_name $argv[1]

    # Check if any command in pipeline failed
    set -l failed 0
    for code in $last_pipestatus
        test $code -ne 0; and set failed 1; and break
    end

    # Format duration
    set -l icon_timer \U000f13ab
    set -l duration_str
    if test -z "$duration" -o "$duration" -lt 1000
        set duration_str (printf "%dms" $duration)
    else if test $duration -lt 60000
        set duration_str (printf "%.1fs" (math "$duration / 1000"))
    else
        set -l mins (math -s0 "$duration / 60000")
        set -l secs (math -s0 "($duration % 60000) / 1000")
        set duration_str "$mins"m"$secs"s
    end

    # Format status
    set -l icon_status \U000f07b7 # 󰞷 keyboard-return
    set -l status_str
    if test (count $last_pipestatus) -gt 1
        set status_str (string join "|" $last_pipestatus)
    else
        set status_str $last_status
    end

    # Color: dim for success, red for failure
    if test $failed -eq 1
        set_color red
    else
        set_color brblack
    end
    echo "$cmd_name: $icon_status $status_str $icon_timer $duration_str"
    set_color normal
end

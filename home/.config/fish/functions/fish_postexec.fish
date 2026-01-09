function fish_postexec --on-event fish_postexec
    set -l duration $CMD_DURATION
    set -l cmd_name (string split ' ' $argv[1])[1]

    # Only show for commands > 1 second
    test -z "$duration" -o "$duration" -lt 1000; and return

    # Format duration
    set -l formatted
    if test $duration -lt 60000
        set formatted (printf "%.1fs" (math "$duration / 1000"))
    else
        set -l mins (math -s0 "$duration / 60000")
        set -l secs (math -s0 "($duration % 60000) / 1000")
        set formatted "$mins"m"$secs"s
    end

    # Icon
    set -l icon_timer \U000f13ab

    # Print with icon (brblack = dim)
    set_color brblack
    echo "$cmd_name: $icon_timer $formatted"
    set_color normal
end

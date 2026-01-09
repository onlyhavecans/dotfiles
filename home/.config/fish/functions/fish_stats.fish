function fish_stats --description 'Show top 20 most used commands'
    history \
        | string replace -r '\s+.*' '' \
        | sort \
        | uniq -c \
        | sort -rn \
        | head -20
end

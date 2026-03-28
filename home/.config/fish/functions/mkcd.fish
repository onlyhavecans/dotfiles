function mkcd
    mkdir -p $argv[1] && builtin cd $argv[1]
end

function run --description "Nix-shell run something"
    set -l app $argv[1]
    set -l rest $argv[2..]
    nix-shell -p $app --run "$app $rest"
end

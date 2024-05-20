function flakify --description "Init flake+direnv"
    if ! test -e flake.nix
        nix flake new -t github:nix-community/nix-direnv .
    else if ! test -e .envrc
        echo 'use flake' >.envrc
        direnv allow .
    end
    nvim flake.nix
end

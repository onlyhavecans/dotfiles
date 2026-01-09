function gcl --description 'Git clone and cd into the cloned directory'
    set -l repo $argv[1]
    set -l rest $argv[2..]

    test -z "$repo"; and echo "Usage: gcl <repo-url> [git-clone-args...]"; and return 1

    # Extract directory name from repo URL
    set -l dir (string replace -r '\.git$' '' (string replace -r '^.*/' '' $repo))

    git clone $repo $rest
    and cd $dir
end

function cover --description "Get go coverage"
    set -lx t "/tmp/go-cover.%self.tmp"
    go test -coverprofile=$t $argv; and go tool cover -html=$t; and unlink $t
end

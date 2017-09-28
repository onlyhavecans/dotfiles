## Some rust
set -l rustup_path $HOME/.cargo/bin
if test -n $CARGO_HOME
  set -l rustup_path $CARGO_HOME/bin
end

append_path $rustup_path
set -x RUST_SRC_PATH $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

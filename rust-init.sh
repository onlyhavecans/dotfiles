#!/usr/bin/env bash

echo "This will probably crash if you haven't run rustup-init yet"
echo "This isn't a regular run script, it's gonna force reinstal crates"

rustup self update
rustup update

rustup install stable
rustup install nightly
rustup default nightly

rustup target add x86_64-unknown-freebsd
rustup target add x86_64-unknown-linux-gnu

rustup component add rls --toolchain nightly
rustup component add rust-analysis --toolchain nightly
rustup component add rust-src --toolchain nightly

rustup run nightly cargo install rustfmt-nightly --force
rustup run nightly cargo install clippy --force
rustup run nightly cargo install racer --force
rustup run nightly cargo install rls --force

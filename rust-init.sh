#!/usr/bin/env bash
set -e
set -x

rustup-init --no-modify-path --default-toolchain beta -y
rustup self update
rustup update

rustup install stable
rustup install nightly
rustup install beta
rustup default beta

rustup target add x86_64-unknown-freebsd
rustup target add x86_64-unknown-linux-gnu

rustup component add rust-src --toolchain beta
rustup component add rust-analysis --toolchain beta
rustup component add rls-preview --toolchain beta
rustup component add rustfmt-preview --toolchain beta

rustup run beta cargo install --force racer
rustup run beta cargo install --force clippy

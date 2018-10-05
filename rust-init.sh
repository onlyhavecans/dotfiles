#!/usr/bin/env bash
set -e
set -x

MY_TOOLCHAIN=stable

rustup-init --no-modify-path --default-toolchain $MY_TOOLCHAIN -y
rustup self update
rustup update

rustup install $MY_TOOLCHAIN

rustup default $MY_TOOLCHAIN

rustup target add x86_64-unknown-freebsd
rustup target add x86_64-unknown-linux-gnu

for component in rustfmt rls-preview rust-analysis rust-src; do
  rustup component add $component --toolchain $MY_TOOLCHAIN
done

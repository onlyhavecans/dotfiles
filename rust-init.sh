#!/usr/bin/env bash
set -e
set -x

MY_TOOLCHAIN=stable

rustup-init --no-modify-path --default-toolchain $MY_TOOLCHAIN -y
rustup self update
rustup update

rustup install stable
rustup install nightly

rustup default $MY_TOOLCHAIN

rustup target add x86_64-unknown-freebsd
rustup target add x86_64-unknown-linux-gnu

rustup component add rls-preview rust-analysis rust-src --toolchain $MY_TOOLCHAIN
rustup component add rustfmt-preview --toolchain $MY_TOOLCHAIN

rustup run $MY_TOOLCHAIN cargo install --force racer

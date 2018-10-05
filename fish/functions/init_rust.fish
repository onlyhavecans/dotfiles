function init_rust
  set -l MY_TOOLCHAIN stable

  curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path --default-toolchain $MY_TOOLCHAIN -y

  rustup self update
  rustup update

  rustup install $MY_TOOLCHAIN

  rustup default $MY_TOOLCHAIN

  rustup target add x86_64-unknown-freebsd
  rustup target add x86_64-unknown-linux-gnu

  for component in rustfmt-preview rls-preview rust-analysis rust-src
    rustup component add $component --toolchain $MY_TOOLCHAIN
  end
end

function init_rust
  set -l MY_TOOLCHAIN stable

  curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path --default-toolchain $MY_TOOLCHAIN -y

  rustup self update
  rustup update

  for MY_TOOLCHAIN in stable beta nightly
    rustup install $MY_TOOLCHAIN

    rustup target add x86_64-unknown-freebsd --toolchain $MY_TOOLCHAIN
    rustup target add x86_64-unknown-linux-gnu --toolchain $MY_TOOLCHAIN

    for component in clippy-preview rustfmt-preview rls-preview rust-analysis rust-src
      rustup component add $component --toolchain $MY_TOOLCHAIN
    end
  end

  rustup default stable
end

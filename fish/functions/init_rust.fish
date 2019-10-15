function init_rust
  set -l MY_TOOLCHAIN stable

  curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path --default-toolchain $MY_TOOLCHAIN -y

  rustup self update
  rustup update
  rustup set profile minimal

  for MY_TOOLCHAIN in stable beta nightly
    rustup install $MY_TOOLCHAIN

    rustup target add x86_64-unknown-freebsd --toolchain $MY_TOOLCHAIN
    rustup target add x86_64-unknown-linux-gnu --toolchain $MY_TOOLCHAIN
  end

  rustup default stable
end

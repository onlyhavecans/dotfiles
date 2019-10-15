function init_rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path --profile=minimal -y

  for MY_TOOLCHAIN in stable beta nightly
    rustup install $MY_TOOLCHAIN

    rustup target add x86_64-unknown-freebsd --toolchain $MY_TOOLCHAIN
    rustup target add x86_64-unknown-linux-gnu --toolchain $MY_TOOLCHAIN
  end
end

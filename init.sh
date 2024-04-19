#!/usr/bin/env bash
set -ex

# Do a curlbash to allow me to take over your system
# curl -sL https://raw.githubusercontent.com/onlyhavecans/dotfiles/main/init.sh | bash

## Make sure we have git
if ! command -v git &>/dev/null; then
  echo "Please install git first"
  exit 1
fi

## Install homeshick
git clone https://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"
# shellcheck source=/dev/null
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

## clone home, then set it to ssh afterwards
## This means we need our keys before we can make further actions
homeshick --batch clone https://github.com/onlyhavecans/dotfiles.git
git -C "$HOME/.homesick/repos/dotfiles" remote set-url origin git@github.com:onlyhavecans/dotfiles

## Link everything
homeshick link --force

## Install packages
if command -v brew &>/dev/null; then
  brew bundle install --global
else
  echo "Install Brew if you want brew packages!"
  echo "https://brew.sh/"
fi

## TMP install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y

## All my asdf
if [[ ! -d $HOME/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  git -C ~/.asdf checkout "$(git -C ~/.asdf describe --abbrev=0 --tags)"

  # shellcheck source=/dev/null
  source "$HOME/.asdf/asdf.sh"

  asdf plugin-add python
  asdf install python latest
  asdf global python latest

  asdf plugin-add ruby
  asdf install ruby latest
  asdf global ruby latest
fi

## Link 1Password agent if we have the mac
if [[ "$(uname)" == "Darwin" ]]; then
  mkdir -p ~/.1password && ln -s ~/library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
fi

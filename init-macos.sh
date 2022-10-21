#!/usr/bin/env bash
set -ex

# Do a curlbash to allow me to take over your system
# curl -sL https://raw.githubusercontent.com/onlyhavecans/dotfiles/main/init-macos.sh | bash

## Make sure we have brew
if ! command -v brew &> /dev/null
then
  echo "Please install homebrew first"
  echo "https://brew.sh/"
  echo 1
fi

if [[ ! -d $HOME/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  git -C ~/.asdf checkout "$(git describe --abbrev=0 --tags)"
fi

## Install homeshick
git clone git://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"
# shellcheck source=/dev/null
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

## clone home, then set it to ssh afterwards
## This means we need our keys before we can make further actions
homeshick --batch clone https://github.com/onlyhavecans/dotfiles.git
git -C "$HOME/.homesick/repos/dotfiles" remote set-url origin git@github.com:onlyhavecans/dotfiles

## Link everything
homeshick link --force

# fin
brew bundle install --global

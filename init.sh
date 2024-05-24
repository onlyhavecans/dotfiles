#!/usr/bin/env bash
set -ex

# Do a curlbash to allow me to take over your system
# curl -sL https://raw.githubusercontent.com/onlyhavecans/dotfiles/main/init.sh | bash

## Make sure we have git
for app in git curl gcc make; do
  if ! command -v "$app" &>/dev/null; then
    echo "Please install $app first"
    exit 1
  fi
done

## Install homeshick
if [[ ! -d $HOME/.homesick/repos/homeshick ]]; then
  git clone https://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"
fi
# shellcheck source=/dev/null
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# clone home, then set it to ssh afterwards
# This means we need our keys before we can make further actions
if [[ ! -d $HOME/.homesick/repos/dotfiles ]]; then
  homeshick --batch clone https://github.com/onlyhavecans/dotfiles.git
  git -C "$HOME/.homesick/repos/dotfiles" remote set-url origin git@github.com:onlyhavecans/dotfiles
fi

# Link everything
homeshick link --force

## Install packages
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [ -d /usr/local/bin ] && PATH="/usr/local/bin:$PATH"
  [ -d /opt/homebrew/bin ] && PATH="/opt/homebrew/bin:$PATH"
  [ -d /home/linuxbrew/.linuxbrew/bin ] && PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  eval $(brew shellenv)
  brew bundle install --file=~/.config/Brewfile
fi

## TMP install
if [[ ! -d $HOME/.config/tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

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
  mkdir -p ~/.1password && ln -sf ~/library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
fi

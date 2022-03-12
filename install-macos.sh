#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install coreutils wget git rcm ripgrep jq nvim awscli gnu-sed
# brew cask install alacritty maccy

# install font
brew tap homebrew/cask-fonts &&
brew cask install font-roboto-mono-nerd-font

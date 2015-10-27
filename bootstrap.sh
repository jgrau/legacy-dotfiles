#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Hombrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew tap Homebrew/bundle
brew bundle
brew cleanup

# Install the rcrc config file so the real rcup command uses our rcm configuration
rcup -K rcrc
rcup

source './osx'

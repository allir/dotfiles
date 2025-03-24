#!/usr/bin/env bash

# Configuration for loading iTerm2 preferences from a custom folder
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.iterm"

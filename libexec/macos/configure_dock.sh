#!/usr/bin/env bash

# System Preferences - Dock & Menubar

## Dock 
### Dock size and magnification. Values 16 - 128
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock magnification -bool yes

### Dock position on screen
defaults write com.apple.dock orientation -string bottom # left | bottom | right

### Minimize windows using effect
defaults write com.apple.dock mineffect -string genie # scale | suck | genie

### Double click a window's titlebar action
defaults write "Apple Global Domain" AppleActionOnDoubleClick -string Maximize # Maximize | Minimize | None

### Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool no

### Animate opening applications
defaults write com.apple.dock launchanim -bool yes

### Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool no

### Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool yes

### Show recent applications in Dock
defaults write com.apple.dock show-recents -bool yes

## Menu bar 
### Automatically show or hide the menubar on desktop
### Automatically show or hide the menubar in fullscreen
defaults write "Apple Global Domain" "_HIHideMenuBar" -bool no
defaults write "Apple Global Domain" AppleMenuBarVisibleInFullscreen -bool no

## Hidden Features

### Show only open applications
#defaults write com.apple.dock static-only -bool yes

### Single application mode
#defaults write com.apple.dock single-app -bool yes

### Show hidden applications semi transparent
#defaults write com.apple.Dock showhidden -bool yes

### Dock "hide speed", 1 is normal speed, lower is fast, higher is slow.
#defaults write com.apple.dock autohide-time-modifier -float 1

### Mission Control animation speed
#defaults write com.apple.dock expose-animation-duration -float 1

## Set the Dock Applications

### Clear the Dock and Recent Apps
defaults delete com.apple.dock persistent-apps 2>/dev/null || true
defaults delete com.apple.dock recent-apps 2>/dev/null || true
#defaults delete com.apple.dock persistent-others

### Set the Dock Applications
dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

dock_spacer() {
    printf '<dict><key>tile-type</key><string>spacer-tile</string></dict>'
}

defaults write com.apple.dock persistent-apps -array \
    "$(dock_item /System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app)" \
    "$(dock_item /System/Applications/Calendar.app)" \
    "$(dock_item /System/Applications/Contacts.app)" \
    "$(dock_item /System/Applications/Notes.app)" \
    "$(dock_item /System/Applications/Reminders.app)" \
    "$(dock_item /Applications/Pages.app)" \
    "$(dock_item /Applications/Numbers.app)" \
    "$(dock_item /Applications/Keynote.app)" \
    "$(dock_item /Applications/Spotify.app)" \
    "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(dock_item /Applications/Slack.app)" \
    "$(dock_item /Applications/iTerm.app)" \
    "$(dock_item /System/Applications/System\ Settings.app)" \

## Restart Dock
killall Dock

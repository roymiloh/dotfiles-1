#!/bin/bash

# --------------------------------------------- #
# | Install Homebrew
# --------------------------------------------- #
if ! cmd_exists 'brew'; then
    printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
fi
print_result $? 'Homebrew'

# --------------------------------------------- #
# | Install Cask
# --------------------------------------------- #
if ! cmd_exists 'brew cask'; then
    brew install caskroom/cask/brew-cask &> /dev/null
    brew tap caskroom/cask &> /dev/null
    brew tap caskroom/versions &> /dev/null
    brew tap caskroom/fonts &> /dev/null
fi
print_result $? 'Cask, Cask fonts, Cask versions'

# --------------------------------------------- #
# | Other taps
# --------------------------------------------- #
if ! cmd_exists 'brew cask'; then
    brew tap beeftornado/rmtree &> /dev/null
    brew install beeftornado/rmtree/brew-rmtree &> /dev/null
fi
print_result $? 'homebrew-rmtree'
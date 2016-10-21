#!/usr/bin/env bash

# --------------------------------------------- #
# | Install Homebrew
# --------------------------------------------- #
if ! cmd_exists 'brew'; then
  printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
fi
print_result $? 'homebrew'

# --------------------------------------------- #
# | Tapping me
# --------------------------------------------- #
if cmd_exists 'brew'; then
  execute "brew tap caskroom/cask" "cask"
  execute "brew tap caskroom/versions" "cask-versions"
  execute "brew tap caskroom/fonts" "cask-fonts"
else
  print_error "homebrew is not installed!"
fi

# --------------------------------------------- #
# | Show that message
# --------------------------------------------- #
echo ""
print_status "The following script checks for the availability of homebrew's formulae
       in the system. It does not update them if needed. Therefore,
       some formulae may not be updated. Try running 'brew upgrade --all' in
       order to update them.
"
print_status "Continue execution in 2 seconds..."
sleep 2

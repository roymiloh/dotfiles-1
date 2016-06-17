#!/usr/bin/env bash

# --------------------------------------------- #
# | Install a hombrew / Cask package
# --------------------------------------------- #

# Store 'brew list' to make it faster
brew_list=""

brew_install() {

  # Check if there is a list
  if [[ ${brew_list} = "" ]]; then
    print_status "Fetching installed packages. This could take a while...\n"
    brew_list=$(brew list && brew cask list)
  fi

  # Arguments
  formula="$1"
  cmd="$2"

  # Check if Homebrew is installed
  if ! cmd_exists 'brew'; then
    print_error "$formula (\`brew\` is not installed)"
  fi

  # Install the specified formula
  if [[ $(echo ${brew_list} | grep "${formula}") ]]; then
    print_success "$formula (already installed)"
  else
    execute "brew $cmd install $formula" "$formula"
  fi
}

# --------------------------------------------- #
# | Install an NPM package
# --------------------------------------------- #

# Store 'npm list' to make it faster
npm_list=""

npm_install() {

  # Check if there is a list
  if [[ ${npm_list} = "" ]]; then
    print_status "Fetching installed packages. This could take a while...\n"
    npm_list=$(npm list -g --depth 0 -s)
  fi

  # Arguments
  package="$1"

  # Check if NPM is installed
  if ! cmd_exists 'npm'; then
    print_error "$package (\`NPM\` is not installed)"
  fi

  # Install the specified package
  if [[ $(echo ${npm_list} | grep "${package}@") ]]; then
    print_success "$package (already installed)"
  else
    execute "npm install $package -g" "$package"
  fi
}

# --------------------------------------------- #
# | Install Atom package
# --------------------------------------------- #
apm_install() {

  # Arguments
  package="$1"

  # Check if APM is installed
  if ! cmd_exists 'apm'; then
    print_error "$package (\`apm\` is not installed)"
  fi

  # Install the specified package
  apm list | grep $package &> /dev/null & show_spinner $! $package
  if [ $? -eq 0 ]; then
    print_success "$package (already installed)"
  else
    execute "apm install $package" "$package"
  fi
}

# --------------------------------------------- #
# | Create a directory in ~/
# --------------------------------------------- #
create_folder() {

  # Arguments
  target="$HOME/$1"

  # Do that.
  if [ -f $target ]; then
    print_error "~/$1 already exists (file), Skipping."
  elif [ -d $target ]; then
    print_error "~/$1 already exists (directory), Skipping."
  else
    mkdir $target &> /dev/null
    print_result $? "Creating folder ~/$1"
  fi
}

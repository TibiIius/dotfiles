#!/usr/bin/env bash

declare -A COLORS=(
  [red]="\033[0;31m"
  [green]="\033[0;32m"
  [yellow]="\033[0;33m"
  [blue]="\033[0;34m"
  [purple]="\033[0;35m"
  [cyan]="\033[0;36m"
  [white]="\033[0;37m"
  [reset]="\033[0m"
)

print_message() {
  echo -e "${COLORS[green]}[+]${COLORS[reset]} ${@}"
}

print_error() {
  echo -e "${COLORS[red]}[-] ERROR: ${@}${COLORS[reset]}"
}

print_warning() {
  echo -e "${COLORS[yellow]}[=] WARN: ${@}${COLORS[reset]}"
}

print_debug() {
  if [ -z "${DEBUG}" ]; then
    return 0
  fi

  echo -e "${COLORS[blue]}[~] DEBUG: ${@}${COLORS[reset]}"
}

# Find brew
find_brew() {
  brew_common_install_paths=("/opt/homebrew/bin/brew" "/home/linuxbrew/.linuxbrew/bin/brew")
  brew_path=""
  for idx in "${!brew_common_install_paths[@]}"; do
    current_path="${brew_common_install_paths[${idx}]}"
    print_debug "Checking for brew at ${current_path}"
    if [ -f "${current_path}" ]; then
      print_message "Brew found at ${current_path}"
      brew_path="${current_path}"
    fi
  done
  export BREW_PATH="${brew_path}"
}

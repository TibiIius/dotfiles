#!/bin/sh

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
  echo -e "${COLORS[yellow]}[=] WARN: ${@}${COLORS[reset]}}"
}

print_debug() {
  if [ -z "${DEBUG}"]; then
    return 0
  fi

  echo -e "${COLORS[blue]}[~] DEBUG: ${@}${COLORS[reset]}}"
}

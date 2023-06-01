#!/usr/bin/env bash

MAX_RETRIES=300

main() {
# First, check if we already have internet (timeout after ${MAX_RETRIES} seconds)
  local __count=1
  until /usr/bin/ping -q -c 1 google.com; do
    if [ ${__count} -ge ${MAX_RETRIES} ]; then break; fi
    sleep 1
    __count=$((${__count}+1))
  done

  # Update chezmoi dotfiles
  /usr/bin/distrobox enter -n archbox -e chezmoi update

  # Update rustup installation
  rustup update

  # Update all global cargo packages using cargo-update and cargo-binstall
  cargo install-update -a
}

main

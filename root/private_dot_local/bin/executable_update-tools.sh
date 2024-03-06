#!/usr/bin/env bash

set -e

MAX_RETRIES=300
ARCHBOX_RUN_COMMAND="distrobox enter -n archbox -e bash -c"
FEDORA_RUN_COMMAND="distrobox enter -n fedora -e bash -c"

main() {
# First, check if we already have internet (timeout after ${MAX_RETRIES} seconds)
  local __count=1
  until /usr/bin/ping -q -c 1 google.com; do
    if [ ${__count} -ge ${MAX_RETRIES} ]; then exit 1337; fi
    sleep 1
    __count=$((${__count}+1))
  done

  # Update chezmoi 
  local __chezmoi_exec="${HOME}/.local/bin/chezmoi"
  ## Update chezmoi itself
  $__chezmoi_exec upgrade
  ## Update dotfiles
  $__chezmoi_exec update

  # Update Flatpak applications
  /usr/bin/flatpak update --noninteractive

  # Rust stuff
  local __cargo_bin="${HOME}/.cargo/bin"
  ## Update rustup installation
  ${__cargo_bin}/rustup update
  ## Update all global cargo packages using cargo-update and cargo-binstall
  ## Do this inside the Fedora Distrobox as we have some builddeps that are not on the host
  ${FEDORA_RUN_COMMAND} '${HOME}/.cargo/bin/cargo install-update -a'


  if [[ $(command -v distrobox) ]]; then
    # Rebuild distrobox containers
    distrobox assemble create --file "${HOME}/.config/distrobox/distrobox.ini"

    if distrobox list | grep -q archbox; then
      # Sync archbox (distrobox) packages
      ## Get package list first
      curl -L --silent \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "https://gist.github.com/TibiIius/672c9c9c6749bec37903378b717cb8dd/raw/" -o "/tmp/packages" && \
      ## Update keyring
      ${ARCHBOX_RUN_COMMAND} 'sudo pacman --noconfirm -Sy archlinux-keyring' && \
      ## Install all the packages that are in the list but not on the host (`--needed` skips already installed packages)
      ${ARCHBOX_RUN_COMMAND} 'sudo pacman --noconfirm --needed -Syu $(</tmp/packages)' && \
      ## Remove all packages that are not in the list but installed on the host systen (command from here https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Install_packages_from_a_list)
      ## Since #? equals to 1 when there are no differences between the two package lists, we just specify || true (not the cleanest, but oh well, it works)
      ${ARCHBOX_RUN_COMMAND} 'sudo pacman --noconfirm -Rsu $(comm -23 <(pacman -Qqen | sort) <(sort /tmp/packages))' || true
    fi
  fi
}

main

#!/bin/sh

CHEZMOI_DIR=$(chezmoi source-path)

source ${CHEZMOI_DIR}/.scripts/helper.sh

print_message "Running Rust setup..."

# Install Rustup if there's no `$HOME/.cargo`
if [ ! -d "$HOME/.cargo" ]; then
  print_message "Installing Rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi


# Install Rust tools
print_message "Installing Rust tools..."
## sccache so that we can cache compilation results, and set the wrapper in case our cargo config doesn't exist yet
## This always reinstall, regardless of being installed already, so we first of all check if it's in $PATH already, and skip this step if it is
[ ! $(command -v sccache) ] && cargo install --locked sccache
RUSTC_WRAPPER=sccache
## Actual packages now
cargo install --locked $(<${CHEZMOI_DIR}/.scripts/data/rust-packages)
## We need to install bandwhich from a fork until its PR is merged (current upstream doesn't work)
cargo install --git=https://github.com/jcgruenhage/bandwhich.git --branch=upgrades-2023-04-11
## cross for cross-compiling
cargo install cross --git https://github.com/cross-rs/cross

print_message "Done setting up Rust!"

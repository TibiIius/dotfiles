#!/bin/sh

# Install Rustup if there's no `$HOME/.cargo`
if [ ! -d "$HOME/.cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

# Install Rust tools
## sccache so that we can cache compilation results
cargo install --locked sccache
## Actual packages now
cargo install --locked $(<./data/rust-packages)
## We need to install bandwhich from a fork until its PR is merged (current upstream doesn't work)
cargo install --git=https://github.com/jcgruenhage/bandwhich.git --branch=upgrades-2023-04-11
## cross for cross-compiling
cargo install cross --git https://github.com/cross-rs/cross

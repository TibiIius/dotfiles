#!/usr/bin/env bash
CHEZMOI_DIR="${HOME}/.local/share/chezmoi"

# We source a helper script
source "${CHEZMOI_DIR}/root/helper.sh"

print_message "Running initial setup script..."

print_message "Installing starship prompt..."

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin --yes

print_message "Done running initial setup!"

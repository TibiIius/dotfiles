#!/bin/sh
CHEZMOI_DIR=$(chezmoi source-path)

# We source a helper script
source "${CHEZMOI_DIR}/.scripts/helper.sh"

print_message "Running initial setup script..."

print_message "Installing starship prompt..."

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin --yes

print_message "Done running initial setup!"

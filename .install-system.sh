#!/bin/bash
set -e

echo "=== Chezmoi Bootstrap Script ==="

# Install chezmoi if not present
if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)"
fi

# Install Bitwarden CLI if not present
if ! command -v bw &> /dev/null; then
    echo "Installing Bitwarden CLI..."
    curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o /tmp/bw.zip
    unzip /tmp/bw.zip -d /tmp
    chmod +x /tmp/bw
    sudo mv /tmp/bw /usr/local/bin/
    rm /tmp/bw.zip
fi

# Check if BW_SESSION is set
if [ -z "$BW_SESSION" ]; then
    echo "Please login to Bitwarden:"
    bw login
    echo ""
    echo "Now unlock your vault and export the session:"
    echo "  bw unlock"
    echo "  export BW_SESSION=\"<session-key>\""
    echo ""
    echo "Then run this script again."
    exit 1
fi

# Initialize chezmoi and apply
echo "Initializing chezmoi..."
if [ -n "$1" ]; then
    # If repo URL provided
    chezmoi init --apply "$1"
else
    # Local initialization
    chezmoi init --apply
fi

echo ""
echo "=== Bootstrap Complete! ==="
echo "You may need to:"
echo "1. Log out and log back in for shell changes"
echo "2. Run 'nvim' to complete LazyVim setup"
echo "3. Restart your terminal"

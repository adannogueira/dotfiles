# Dotfiles with Chezmoi + Bitwarden

## Bootstrap on New Machine

### 1. Install Bitwarden CLI and Login
```bash
# Install Bitwarden CLI
curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o bw.zip
unzip bw.zip
chmod +x bw
sudo mv bw /usr/local/bin/
rm bw.zip

# Login (will prompt for 2FA if enabled)
bw login

# Unlock and export session
export BW_SESSION="$(bw unlock --raw)"
```

### 2. Bootstrap with Chezmoi
```bash
# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/adannogueira/dotfiles.git
```

### 3. Post-Installation
```bash
# Complete Neovim setup
nvim

# Restart shell or log out/in for zsh changes
```

## Updating Dotfiles
```bash
# Pull latest changes and apply
chezmoi update

# Edit a file
chezmoi edit ~/.zshrc

# Add a new file
chezmoi add ~/.newfile

# Apply changes
chezmoi apply
```

## Refreshing Bitwarden Session

If templates fail due to expired session:
```bash
export BW_SESSION="$(bw unlock --raw)"
chezmoi apply
```
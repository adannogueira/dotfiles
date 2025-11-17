# Dotfiles with Chezmoi + Bitwarden

## Bootstrap on New Machine

### One-Liner Setup (Recommended)

```bash
# Install Bitwarden CLI, login, and export session
curl -L 'https://vault.bitwarden.com/download/?app=cli&platform=linux' -o bw.zip && unzip bw.zip && chmod +x bw && sudo mv bw /usr/local/bin/ && rm bw.zip && export BW_SESSION="$(bw login --raw)" && sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/adannogueira/dotfiles.git
```

### Step-by-Step Setup

#### 1. Install and Setup Bitwarden CLI
```bash
# Install Bitwarden CLI
curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o bw.zip
unzip bw.zip
chmod +x bw
sudo mv bw /usr/local/bin/
rm bw.zip

# Login and export session in one step (will prompt for 2FA if enabled)
export BW_SESSION="$(bw login --raw)"
```

#### 2. Bootstrap with Chezmoi
```bash
# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/adannogueira/dotfiles.git
```

#### 3. Post-Installation
```bash
# Complete Neovim setup
nvim

# Restart shell or log out/in for zsh changes
```

## Required Bitwarden Items

Your Bitwarden vault must contain the following items:

1. **gpg-private-key**
   - Notes: base64-encoded GPG private key
   - Custom field `passphrase`: GPG key passphrase
   
2. **ssh-private-key**
   - Notes: base64-encoded SSH private key

3. **ssh-public-key**
   - Notes: SSH public key content

4. **atuin-credentials**
   - Username: atuin username
   - Password: atuin password
   - Custom field `synckey`: atuin sync key

5. **ngrok-token**
   - Password: ngrok auth token

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
# Unlock and export session
export BW_SESSION="$(bw unlock --raw)"

# Sync vault
bw sync

# Apply changes
chezmoi apply
```
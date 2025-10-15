# Auto install (PC)
## One-line bootstrap (chezmoi will automatically run .install-system.sh)
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/adannogueira/dotfiles.git

# Manual install (PC)
## Clone the repo first
git clone https://github.com/adannogueira/dotfiles.git /tmp/dotfiles

## Run the bootstrap script
bash /tmp/dotfiles/.install-system.sh https://github.com/adannogueira/dotfiles.git

# Auto install (Devcontainer)

## Add to your .devcontainer/devcontainer.json:
```json
{
  "postCreateCommand": "sh -c \"$(curl -fsLS https://raw.githubusercontent.com/adannogueira/dotfiles/main/bootstrap.sh)\" -- https://github.com/adannogueira/dotfiles.git"
}
```

## Or create .devcontainer/postCreateCommand.sh:
```bash
#!/bin/bash
set -e

# Install essentials
apt-get update
apt-get install -y curl git

# Bootstrap dotfiles
sh -c "$(curl -fsLS https://raw.githubusercontent.com/adannogueira/dotfiles/main/bootstrap.sh)" -- https://github.com/adannogueira/dotfiles.git
```
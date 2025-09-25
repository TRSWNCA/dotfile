#!/bin/bash

# Dotfiles Installation Script
# This script creates symlinks for all configuration files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo -e "${BLUE}🚀 Installing dotfiles from $DOTFILES_DIR${NC}"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    if [ -L "$target" ]; then
        echo -e "${YELLOW}⚠️  $description already symlinked, skipping...${NC}"
        return
    fi
    
    if [ -e "$target" ]; then
        echo -e "${YELLOW}⚠️  $description exists, creating backup...${NC}"
        mv "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sf "$source" "$target"
    echo -e "${GREEN}✅ Linked $description${NC}"
}

# Create backup directory
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo -e "${BLUE}📁 Created backup directory: $BACKUP_DIR${NC}"

# Polybar configuration
if [ -d "$CONFIG_DIR/polybar" ]; then
    create_symlink "$CONFIG_DIR/polybar" "$HOME/.config/polybar" "Polybar config"
fi

# i3 configuration
if [ -d "$CONFIG_DIR/i3" ]; then
    create_symlink "$CONFIG_DIR/i3" "$HOME/.config/i3" "i3 config"
fi

# Zsh configuration
if [ -f "$CONFIG_DIR/zsh/.zshrc" ]; then
    create_symlink "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc" "Zsh config"
fi

# Environment file (if it exists)
if [ -f "$CONFIG_DIR/zsh/.env" ]; then
    create_symlink "$CONFIG_DIR/zsh/.env" "$HOME/.env" "Environment file"
fi

# Git configuration
if [ -f "$CONFIG_DIR/git/.gitconfig" ]; then
    create_symlink "$CONFIG_DIR/git/.gitconfig" "$HOME/.gitconfig" "Git config"
fi

# Vim configuration
if [ -d "$CONFIG_DIR/vim" ]; then
    create_symlink "$CONFIG_DIR/vim" "$HOME/.config/nvim" "Neovim config"
    create_symlink "$CONFIG_DIR/vim" "$HOME/.vim" "Vim config"
fi

# Alacritty configuration
if [ -d "$CONFIG_DIR/alacritty" ]; then
    create_symlink "$CONFIG_DIR/alacritty" "$HOME/.config/alacritty" "Alacritty config"
fi

# Rofi configuration
if [ -d "$CONFIG_DIR/rofi" ]; then
    create_symlink "$CONFIG_DIR/rofi" "$HOME/.config/rofi" "Rofi config"
fi

# Compton configuration
if [ -d "$CONFIG_DIR/compton" ]; then
    create_symlink "$CONFIG_DIR/compton" "$HOME/.config/compton" "Compton config"
fi

# Picom configuration
if [ -d "$CONFIG_DIR/picom" ]; then
    create_symlink "$CONFIG_DIR/picom" "$HOME/.config/picom" "Picom config"
fi

echo -e "${GREEN}🎉 Installation complete!${NC}"
echo -e "${BLUE}💡 Tip: Restart your terminal or run 'source ~/.zshrc' to apply shell changes${NC}"
echo -e "${BLUE}💡 Tip: Restart your window manager to apply i3/polybar changes${NC}"
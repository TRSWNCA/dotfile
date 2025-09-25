#!/bin/bash

# Update dotfiles from system configuration
# This script copies current system configs to the dotfiles repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo -e "${BLUE}🔄 Updating dotfiles from system configuration...${NC}"

# Function to copy config with backup
copy_config() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    if [ -e "$source" ]; then
        # Create backup if target exists
        if [ -e "$target" ]; then
            echo -e "${YELLOW}⚠️  Backing up existing $description...${NC}"
            cp -r "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
        fi
        
        # Copy the config
        cp -r "$source" "$target"
        echo -e "${GREEN}✅ Updated $description${NC}"
    else
        echo -e "${RED}❌ $description not found at $source${NC}"
    fi
}

# Update polybar config
copy_config "$HOME/.config/polybar" "$CONFIG_DIR/polybar" "Polybar config"

# Update i3 config
copy_config "$HOME/.config/i3" "$CONFIG_DIR/i3" "i3 config"

# Update zsh config
copy_config "$HOME/.zshrc" "$CONFIG_DIR/zsh/.zshrc" "Zsh config"

# Update environment file (if it exists)
copy_config "$HOME/.env" "$CONFIG_DIR/zsh/.env" "Environment file"

# Update git config
copy_config "$HOME/.gitconfig" "$CONFIG_DIR/git/.gitconfig" "Git config"

# Update vim/neovim config
if [ -d "$HOME/.config/nvim" ]; then
    copy_config "$HOME/.config/nvim" "$CONFIG_DIR/vim/nvim" "Neovim config"
elif [ -d "$HOME/.vim" ]; then
    copy_config "$HOME/.vim" "$CONFIG_DIR/vim/vim" "Vim config"
fi

# Update alacritty config
copy_config "$HOME/.config/alacritty" "$CONFIG_DIR/alacritty" "Alacritty config"

# Update rofi config
copy_config "$HOME/.config/rofi" "$CONFIG_DIR/rofi" "Rofi config"

# Update picom/compton config
if [ -d "$HOME/.config/picom" ]; then
    copy_config "$HOME/.config/picom" "$CONFIG_DIR/picom" "Picom config"
elif [ -d "$HOME/.config/compton" ]; then
    copy_config "$HOME/.config/compton" "$CONFIG_DIR/compton" "Compton config"
fi

echo -e "${GREEN}🎉 Update complete!${NC}"
echo -e "${BLUE}💡 Don't forget to commit your changes: git add . && git commit -m 'Update configs'${NC}"
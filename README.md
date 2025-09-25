# Dotfiles

My personal configuration files for various applications and tools.

## Structure

```
├── config/           # Configuration files organized by application
│   ├── polybar/      # Polybar configuration
│   ├── i3/           # i3 window manager configuration
│   ├── zsh/          # Zsh shell configuration
│   ├── git/          # Git configuration
│   ├── vim/          # Vim/Neovim configuration
│   ├── alacritty/    # Alacritty terminal configuration
│   ├── rofi/         # Rofi launcher configuration
│   ├── compton/      # Compton compositor configuration
│   └── picom/        # Picom compositor configuration
├── scripts/          # Utility scripts
├── install.sh        # Installation script
└── README.md         # This file
```

## Installation

Run the installation script to symlink all configuration files to their appropriate locations:

```bash
./install.sh
```

## Manual Installation

If you prefer to install configurations manually, you can create symlinks for specific applications:

```bash
# Example for polybar
ln -sf ~/Documents/dotfile/config/polybar/config ~/.config/polybar/config

# Example for i3
ln -sf ~/Documents/dotfile/config/i3/config ~/.config/i3/config

# Example for zsh
ln -sf ~/Documents/dotfile/config/zsh/.zshrc ~/.zshrc
```

## Applications

- **Polybar**: Status bar for window managers
- **i3**: Tiling window manager
- **Zsh**: Shell configuration with Oh My Zsh or similar
- **Git**: Git configuration and aliases
- **Vim/Neovim**: Text editor configuration
- **Alacritty**: GPU-accelerated terminal emulator
- **Rofi**: Application launcher
- **Compton/Picom**: Compositor for visual effects

## Backup

Before installing, make sure to backup your existing configuration files:

```bash
# Create backup directory
mkdir -p ~/.config-backup

# Backup existing configs
cp -r ~/.config/polybar ~/.config-backup/ 2>/dev/null || true
cp -r ~/.config/i3 ~/.config-backup/ 2>/dev/null || true
cp ~/.zshrc ~/.config-backup/ 2>/dev/null || true
```

## Contributing

Feel free to suggest improvements or report issues with any of the configurations.
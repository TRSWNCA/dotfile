#!/usr/bin/env python3

"""
Dotfiles Installation Script
This script creates symlinks for all configuration files
"""

import os
import sys
from pathlib import Path
from datetime import datetime
from shutil import move

try:
    import yaml
except ImportError:
    print("○ Error: PyYAML is required. Install it with: pip install pyyaml")
    sys.exit(1)

# Colors for output
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'  # No Color

def print_colored(message, color=Colors.NC):
    """Print colored message"""
    print(f"{color}{message}{Colors.NC}")

def create_symlink(source, target, description):
    """
    Create symlink with backup
    
    Args:
        source: Source file/directory path (Path object)
        target: Target symlink path (Path object)
        description: Human-readable description
    """
    # Check if target is already a symlink
    if target.is_symlink():
        print_colored(f"○ {description} already symlinked, skipping...", Colors.YELLOW)
        return
    
    # Check if target exists (file or directory)
    if target.exists():
        print_colored(f"○ {description} exists, creating backup...", Colors.YELLOW)
        
        # Create backup path: replace $HOME with "home" and preserve directory structure
        home = Path.home()
        try:
            # Try to get relative path from home
            backup_path = target.relative_to(home)
            backup_path = Path("home") / backup_path
        except ValueError:
            # Target is not under $HOME, use full path with slashes replaced
            backup_path_str = str(target).replace(os.sep, "_").replace("/", "_")
            backup_path = Path(backup_path_str)
        
        # Add timestamp to backup filename
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_file = BACKUP_DIR / f"{backup_path}.backup.{timestamp}"
        
        # Create parent directory for backup
        backup_file.parent.mkdir(parents=True, exist_ok=True)
        
        # Move original to backup location
        move(str(target), str(backup_file))
        print_colored(f"   Backed up to: {backup_file}", Colors.BLUE)
    
    # Create parent directory if it doesn't exist
    target.parent.mkdir(parents=True, exist_ok=True)
    
    # Create symlink
    # Use absolute path for source to avoid broken symlinks
    source_absolute = source.resolve()
    target.symlink_to(source_absolute)
    print_colored(f"● Linked {description}", Colors.GREEN)

def load_config(dotfiles_dir):
    """
    Load configuration from YAML file
    
    Args:
        dotfiles_dir: Path to dotfiles directory
        
    Returns:
        List of configuration dictionaries
    """
    config_file = dotfiles_dir / "install.yaml"
    
    if not config_file.exists():
        print_colored(f"○ Configuration file not found: {config_file}", Colors.RED)
        sys.exit(1)
    
    try:
        with open(config_file, 'r') as f:
            config = yaml.safe_load(f)
        return config.get('configs', [])
    except yaml.YAMLError as e:
        print_colored(f"○ Error parsing YAML file: {e}", Colors.RED)
        sys.exit(1)
    except Exception as e:
        print_colored(f"○ Error reading configuration file: {e}", Colors.RED)
        sys.exit(1)

def expand_path(path_str, home):
    """
    Expand path string, handling ~ and environment variables
    
    Args:
        path_str: Path string (may contain ~)
        home: Path object for home directory
        
    Returns:
        Expanded Path object
    """
    # Replace ~ with home directory
    if path_str.startswith('~/'):
        return home / path_str[2:]
    elif path_str == '~':
        return home
    else:
        # Expand environment variables
        expanded = os.path.expandvars(path_str)
        return Path(expanded).expanduser()

def main():
    """Main installation function"""
    # Get the directory where this script is located
    dotfiles_dir = Path(__file__).parent.resolve()
    config_dir = dotfiles_dir / "config"
    global BACKUP_DIR
    BACKUP_DIR = dotfiles_dir / ".backup"
    
    print_colored(f"🚀 Installing dotfiles from {dotfiles_dir}", Colors.BLUE)
    
    # Load configuration from YAML
    configs = load_config(dotfiles_dir)
    
    # Create backup directory in repo
    BACKUP_DIR.mkdir(parents=True, exist_ok=True)
    print_colored(f"📁 Backup directory: {BACKUP_DIR}", Colors.BLUE)
    
    home = Path.home()
    
    # Process each configuration entry
    for config_entry in configs:
        source_rel = config_entry.get('source')
        target_str = config_entry.get('target')
        description = config_entry.get('description', 'Config')
        config_type = config_entry.get('type', 'file')
        optional = config_entry.get('optional', False)
        
        if not source_rel or not target_str:
            print_colored(f"○ Skipping invalid config entry: {config_entry}", Colors.YELLOW)
            continue
        
        # Build source path
        source_path = config_dir / source_rel
        
        # Check if source exists (skip if optional and doesn't exist)
        if optional and not source_path.exists():
            continue
        
        # Validate source based on type
        if config_type == 'directory' and not source_path.is_dir():
            if not optional:
                print_colored(f"○ Source directory not found: {source_path}, skipping...", Colors.YELLOW)
            continue
        elif config_type == 'file' and not source_path.is_file():
            if not optional:
                print_colored(f"○ Source file not found: {source_path}, skipping...", Colors.YELLOW)
            continue
        
        # Expand target path
        target_path = expand_path(target_str, home)
        
        # Create symlink
        create_symlink(source_path, target_path, description)
    
    print_colored("🎉 Installation complete!", Colors.GREEN)
    print_colored("💡 Tip: Restart your terminal or run 'source ~/.zshrc' to apply shell changes", Colors.BLUE)
    print_colored("💡 Tip: Restart your window manager to apply i3/polybar changes", Colors.BLUE)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print_colored("\n○ Installation cancelled by user", Colors.RED)
        sys.exit(1)
    except Exception as e:
        print_colored(f"\n○ Error: {e}", Colors.RED)
        sys.exit(1)

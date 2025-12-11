# NixOS Dotfiles

## Description
A modular NixOS configuration with Home Manager for a complete system setup. Includes traditional dotfiles for compatibility.

## Features
- **Flake-based NixOS configuration** with reproducible system setup
- **Home Manager integration** for user environment management
- **Modular configuration system** with separate core and home-manager modules
- **Multi-host support** (personal machine, workplace' machines) with shared and host-specific configs
- **Custom configurations**:
  - Graphics: NVIDIA/Intel dual GPU setup with VFIO
  - Virtualization: Docker, Podman, Looking-Glass
  - Development: Neovim, Tmux, Git, Starship
  - Wayland: Hyprland, Rofi, Waybar
  - Audio, Bluetooth, Laptop-specific optimizations

## Repository Structure
```
nixos/
├── flake.nix              # Main flake configuration
├── hosts/                 # Host-specific configurations
│   ├── laptop/
│   └── workplace/
├── modules/               # Shared configuration modules
│   ├── core/             # System-level modules
│   └── home-manager/     # User environment modules
└── nix-shell/            # Development shell configuration

keybinds/                 # Traditional dotfiles (symlinked)
scripts/                  # Utility scripts
.config/                  # Application configs (kitty, rofi, waybar, etc.)
```

## Usage

### NixOS Installation
```sh
# Clone the repository
git clone --recursive https://github.com/HeRo3S/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Rebuild NixOS configuration
sudo nixos-rebuild switch --flake .#laptop  # or .#sanan

# Rebuild home configuration
home-manager switch --flake .#laptop
```

### Development Shell
```sh
nix develop
```

## Configuration Options
- `customCfg.graphics.*` - GPU configuration (NVIDIA/Intel)
- `customCfg.virtualization.*` - Container and VM support
- `customCfg.vfio.*` - GPU passthrough configuration
- `customHomeCfg.programming.*` - Development tools setup

## Legacy Support
Traditional dotfiles are maintained in `keybinds/`, `scripts/`, and `.config/` and symlinked via Home Manager for compatibility with non-NixOS systems.

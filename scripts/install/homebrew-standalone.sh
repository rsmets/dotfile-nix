#!/bin/bash
#
# Homebrew Standalone Installation Script
# =======================================
#
# This script installs all packages from the dotfile-nix configuration
# using Homebrew directly, without requiring nix-darwin.
#
# Use this when:
# - Corporate policies prevent full nix-darwin installation
# - You want a quick setup without Nix
# - You need to replicate your environment on a restricted machine
#
# Usage:
#   chmod +x scripts/install/homebrew-standalone.sh
#   ./scripts/install/homebrew-standalone.sh
#
# Options:
#   --casks-only    Install only GUI applications
#   --brews-only    Install only CLI tools
#   --fonts-only    Install only fonts
#   --skip-taps     Skip adding custom taps
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🍺 Homebrew Standalone Installation${NC}"
echo -e "${BLUE}Installing packages from dotfile-nix configuration${NC}"
echo ""

# Parse arguments
INSTALL_CASKS=true
INSTALL_BREWS=true
INSTALL_FONTS=true
SKIP_TAPS=false

for arg in "$@"; do
  case $arg in
    --casks-only)
      INSTALL_BREWS=false
      INSTALL_FONTS=false
      ;;
    --brews-only)
      INSTALL_CASKS=false
      INSTALL_FONTS=false
      ;;
    --fonts-only)
      INSTALL_CASKS=false
      INSTALL_BREWS=false
      ;;
    --skip-taps)
      SKIP_TAPS=true
      ;;
  esac
done

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH for this session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

echo -e "${GREEN}✓ Homebrew ready${NC}"

# =============================================================================
# TAPS - Custom repositories
# =============================================================================
if [ "$SKIP_TAPS" = false ]; then
    echo -e "\n${BLUE}Adding custom taps...${NC}"
    
    TAPS=(
        "warrensbox/tap"      # For tfswitch
        "localstack/tap"      # For localstack-cli
        "nguyenphutrong/tap"  # For quotio
    )
    
    for tap in "${TAPS[@]}"; do
        echo -e "  Adding $tap..."
        brew tap "$tap" 2>/dev/null || true
    done
    
    echo -e "${GREEN}✓ Taps configured${NC}"
fi

# =============================================================================
# CLI TOOLS (brews)
# =============================================================================
if [ "$INSTALL_BREWS" = true ]; then
    echo -e "\n${BLUE}Installing CLI tools...${NC}"
    
    BREWS=(
        # Core System Utilities
        "coreutils"
        "duf"
        "dust"
        "gnu-getopt"
        "fd"
        "mas"
        "zoxide"
        "tree"
        "stow"
        
        # Python Development
        "uv"
        "poetry"
        "python@3.12"
        "python@3.13"
        
        # Development Tools
        "cmake"
        "duckdb"
        "maven"
        "neovim"
        "pkg-config"
        "git"
        "gh"
        "git-lfs"
        "lazygit"
        "go"
        "node"
        "shellcheck"
        "rust-analyzer"
        
        # Text Processing
        "bat"
        "fzf"
        "jq"
        "ripgrep"
        "yq"
        
        # Terminal Utilities
        "bottom"
        "btop"
        "eza"
        "glow"
        "neofetch"
        "starship"
        "tldr"
        "tmux"
        
        # Security
        "gnupg"
        "sops"
        "age"
        
        # Cloud and Infrastructure
        "awscli"
        "helm"
        "localstack/tap/localstack-cli"
        "terraform-docs"
        "tflint"
        "warrensbox/tap/tfswitch"
        
        # Version Managers
        "mise"
        "nvm"
        "pnpm"
        
        # Git Enhancement
        "git-delta"
        
        # Visualization
        "graphviz"
        "slides"
        
        # File Sync
        "unison"
        
        # Shell Prompt
        "oh-my-posh"
    )
    
    for brew in "${BREWS[@]}"; do
        echo -e "  Installing $brew..."
        brew install "$brew" 2>/dev/null || echo -e "    ${YELLOW}⚠ Failed to install $brew${NC}"
    done
    
    echo -e "${GREEN}✓ CLI tools installed${NC}"
fi

# =============================================================================
# GUI APPLICATIONS (casks)
# =============================================================================
if [ "$INSTALL_CASKS" = true ]; then
    echo -e "\n${BLUE}Installing GUI applications...${NC}"
    
    CASKS=(
        # Development - JDKs
        "temurin@11"
        "temurin@17"
        
        # Communication
        "slack"
        "discord"
        
        # Office
        "microsoft-office"
        
        # Development Tools
        "cursor"
        "antigravity"
        "claude-code"
        "docker-desktop"
        "postman"
        
        # Terminal and System
        "alacritty"
        "ghostty"
        "karabiner-elements"
        "rectangle"
        "the-unarchiver"
        "displaylink"
        
        # Productivity
        "alfred"
        "kiro"
        "kiro-cli"
        
        # Browsers and Communication
        "bitwarden"
        "brave-browser"
        "google-chrome"
        "arc"
        "firefox"
        "chatgpt"
        "claude"
        "goose"
        "lm-studio"
        "insync"
        "obsidian"
        "quotio"
        "spark"
        "macwhisper"
        "spotify"
        "whatsapp"
        "zoom"
        
        # System Utilities
        "bartender"
        "stats"
        "keepassxc"
        
        # Database and Debugging
        "dbeaver-community"
        "charles"
        "sourcetree"
        
        # Media
        "vlc"
        
        # Cloud/VPN
        "tailscale-app"
    )
    
    for cask in "${CASKS[@]}"; do
        echo -e "  Installing $cask..."
        brew install --cask "$cask" 2>/dev/null || echo -e "    ${YELLOW}⚠ Failed to install $cask${NC}"
    done
    
    echo -e "${GREEN}✓ GUI applications installed${NC}"
fi

# =============================================================================
# FONTS
# =============================================================================
if [ "$INSTALL_FONTS" = true ]; then
    echo -e "\n${BLUE}Installing fonts...${NC}"
    
    FONTS=(
        # Primary Nerd Fonts
        "font-jetbrains-mono-nerd-font"
        "font-fira-code-nerd-font"
        "font-hack-nerd-font"
        "font-meslo-lg-nerd-font"
        
        # System UI Fonts
        "font-inter"
        "font-source-serif-4"
        "font-source-sans-3"
        
        # Additional Nerd Fonts
        "font-sauce-code-pro-nerd-font"
        "font-ubuntu-mono-nerd-font"
        "font-dejavu-sans-mono-nerd-font"
        "font-inconsolata-nerd-font"
    )
    
    for font in "${FONTS[@]}"; do
        echo -e "  Installing $font..."
        brew install --cask "$font" 2>/dev/null || echo -e "    ${YELLOW}⚠ Failed to install $font${NC}"
    done
    
    echo -e "${GREEN}✓ Fonts installed${NC}"
fi

# =============================================================================
# SUMMARY
# =============================================================================
echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. Restart your terminal"
echo -e "  2. Configure your shell (copy aliases from home-manager/aliases/)"
echo -e "  3. Set up app preferences manually"
echo ""
echo -e "${BLUE}To see what was installed:${NC}"
echo -e "  brew list"
echo -e "  brew list --cask"
echo ""

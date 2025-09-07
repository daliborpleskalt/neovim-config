#!/bin/bash
# Ultimate AI-Powered Neovim Installation Script for macOS
# Python-free version - no pynvim needed!

set -e

echo "🚀 Starting Ultimate AI-Powered Neovim Installation (Python-free)..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only."
    exit 1
fi

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    print_error "Homebrew is required but not installed."
    echo "Please install Homebrew from https://brew.sh/"
    exit 1
fi

print_status "Installing dependencies..."

# Install Neovim 0.11+
print_status "Installing Neovim..."
brew install neovim

# Install essential tools
print_status "Installing essential tools..."
brew install node npm fd ripgrep fzf

print_success "✅ No Python dependencies needed - all plugins are Lua-based!"

# Install Node.js language servers
print_status "Installing Node.js language servers..."
npm install -g typescript typescript-language-server
npm install -g @angular/language-server

# Install MCP Hub for AI tool integration
print_status "Installing MCP Hub..."
npm install -g mcp-hub

# Install Rust and rust-analyzer
if ! command -v rustc &> /dev/null; then
    print_status "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
    print_warning "Please run 'source ~/.cargo/env' after installation"
fi

# Add rust-analyzer component
if command -v rustup &> /dev/null; then
    print_status "Adding rust-analyzer component..."
    rustup component add rust-analyzer
fi

# Java LSP (optional - only if Java is detected)
if command -v java &> /dev/null; then
    print_status "Java detected, installing Java LSP..."
    brew install jdtls
else
    print_status "Java not detected, skipping Java LSP (you can install later if needed)"
fi

# Setup configuration directories
print_status "Setting up Neovim configuration directories..."

# Backup existing config
if [[ -d "$HOME/.config/nvim" ]]; then
    print_warning "Backing up existing Neovim configuration..."
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    print_success "Backup created"
fi

# Create config directories
mkdir -p "$HOME/.config/nvim/lua/config"
mkdir -p "$HOME/.config/nvim/lua/plugins"

# Create MCP servers configuration
if [[ ! -f "$HOME/mcpservers.json" ]]; then
    print_status "Creating MCP servers configuration..."
    cat > "$HOME/mcpservers.json" << 'EOF'
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "ALLOWED_DIRS": "~/Projects,~/Development"
      }
    },
    "git": {
      "command": "npx", 
      "args": ["-y", "@modelcontextprotocol/server-git"]
    },
    "fetch": {
      "command": "uvx",
      "args": ["mcp-server-fetch"]
    }
  }
}
EOF
    print_success "MCP servers configuration created"
fi

# Create environment variables template
if [[ ! -f "$HOME/.env.nvim" ]]; then
    print_status "Creating environment variables template..."
    cat > "$HOME/.env.nvim" << 'EOF'
# AI API Keys for Neovim
export ANTHROPIC_API_KEY="your-anthropic-key-here"
export OPENAI_API_KEY="your-openai-key-here"  
export PERPLEXITY_API_KEY="your-perplexity-key-here"

# Optional: Brave Search API for MCP
export BRAVE_API_KEY="your-brave-search-key-here"
EOF
    print_success "Environment template created"
    print_warning "Please edit ~/.env.nvim with your actual API keys"
    print_warning "Then add 'source ~/.env.nvim' to your ~/.zshrc"
fi

print_success "🎉 Installation completed!"
print_status ""
print_status "📋 Next steps:"
echo "1. 📁 Copy configuration files: cp -r ultimate-nvim/* ~/.config/nvim/"
echo "2. 🔑 Edit ~/.env.nvim with your API keys"
echo "3. 🐚 Add 'source ~/.env.nvim' to your ~/.zshrc"
echo "4. 🔄 Restart your terminal or run 'source ~/.zshrc'"
echo "5. 🚀 Run 'nvim' and let plugins install automatically"
print_status ""
print_status "✨ Benefits of Python-free setup:"
echo "   - No externally-managed-environment errors"
echo "   - Faster installation and startup"
echo "   - Cleaner dependency management"
echo "   - All plugins are modern Lua-based"
print_status ""
print_status "🔧 If you ever need Python support later:"
echo "   - For Python development: Install python-lsp-server via Mason"
echo "   - For Python plugins: brew install python-neovim (but you won't need it)"

print_success "🎯 Your Python-free AI development environment is ready!"

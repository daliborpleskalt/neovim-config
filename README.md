# AI-Powered Neovim Setup

A laser-focused, performance-optimized Neovim configuration with cutting-edge AI integration.

## Features

- 🤖 **Triple AI Integration**: Avante.nvim, CodeCompanion.nvim, and Parrot.nvim
- 🔌 **MCP Support**: Universal tool integration via Model Context Protocol
- 🎨 **Catppuccin Mocha**: Beautiful, consistent theming
- ⚡ **Performance Optimized**: Memory and CPU optimizations for large codebases
- 🔒 **Security First**: API rate limiting, audit trails, and secure defaults
- 🌳 **Neo-tree**: Modern file explorer with Git integration
- 🔍 **Telescope**: Blazing-fast fuzzy finding
- 💻 **Multi-Language**: TypeScript/Angular, React/JavaScript, Rust, Java, Lua

## Quick Start

### 1. Prerequisites

- macOS (latest version)
- Homebrew installed
- API keys for AI providers (Anthropic, OpenAI, Perplexity)

### 2. Installation

```bash
# Clone or download the configuration files
# Run the installation script
chmod +x install.sh
./install.sh

# Copy configuration files to ~/.config/nvim/
cp -r . ~/.config/nvim/

# Setup environment variables
cp ~/.env.nvim ~/.env.nvim.local
# Edit ~/.env.nvim.local with your API keys
source ~/.env.nvim.local

# Add to your shell profile
echo 'source ~/.env.nvim.local' >> ~/.zshrc
```

### 3. First Launch

```bash
nvim
```

The first launch will automatically install all plugins. Wait for completion.

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua      # Core Neovim options
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   └── security.lua     # Security configurations
│   └── plugins/
│       ├── ai-core.lua      # AI plugins configuration
│       ├── colorscheme.lua  # Catppuccin theme
│       ├── completion.lua   # nvim-cmp setup
│       ├── lsp.lua          # Language server configuration
│       ├── neo-tree.lua     # File explorer
│       ├── telescope.lua    # Fuzzy finder
│       ├── treesitter.lua   # Syntax highlighting
│       └── ui.lua           # UI enhancements
└── mcpservers.json          # MCP servers configuration
```

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>e` - Toggle Neo-tree

### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fr` - Recent files

### AI Features
- `<leader>aa` - Avante Ask
- `<leader>ar` - Avante Refactor (visual mode)
- `<leader>cc` - CodeCompanion Chat
- `<leader>pp` - Parrot Chat

### LSP
- `gd` - Go to definition
- `gr` - Go to references  
- `K` - Show hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions

## AI Providers Setup

### Claude (Anthropic)
1. Get API key from https://console.anthropic.com/
2. Add to `~/.env.nvim`: `export ANTHROPIC_API_KEY="your-key"`

### Perplexity
1. Get API key from https://www.perplexity.ai/settings/api
2. Add to `~/.env.nvim`: `export PERPLEXITY_API_KEY="your-key"`

### OpenAI (Optional)
1. Get API key from https://platform.openai.com/api-keys
2. Add to `~/.env.nvim`: `export OPENAI_API_KEY="your-key"`

## Security Features

- **API Rate Limiting**: Automatic request throttling
- **Audit Trails**: All AI interactions logged
- **Secure Defaults**: Restricted file access for MCP servers
- **Environment Isolation**: API keys in separate environment files

## Performance Optimizations

- **Memory Management**: Optimized for large files and codebases
- **Lazy Loading**: Plugins loaded only when needed
- **Tree-sitter Optimizations**: Asynchronous syntax highlighting
- **LSP Efficiency**: Debounced requests and selective formatting

## Language Support

### TypeScript/Angular
- Full LSP support with inlay hints
- Angular Language Server for templates
- Nx monorepo compatibility

### Rust  
- rust-analyzer with clippy integration
- Advanced diagnostics and formatting
- Cargo integration

### Java
- Eclipse JDT Language Server
- Maven/Gradle project support

## Troubleshooting

### Plugin Installation Issues
```bash
# Clear plugin cache
rm -rf ~/.local/share/nvim
nvim --headless "+Lazy! sync" +qa
```

### LSP Not Working
```bash
# Check Mason installations
:Mason
# Reinstall language servers if needed
```

### AI Features Not Responding
1. Verify API keys in environment
2. Check rate limits in `:messages`
3. Review audit log: `~/.local/share/nvim/ai_audit.log`

## Customization

### Adding New AI Providers
Edit `lua/plugins/ai-core.lua` and add provider configuration.

### Custom Keymaps
Add to `lua/config/keymaps.lua` for global mappings or individual plugin files.

### Performance Tuning
Adjust settings in `lua/config/options.lua` for your specific needs.

## Contributing

This configuration is designed for personal use but can be adapted. Key areas for customization:
- Language server configurations
- AI provider preferences  
- Theme and UI customizations
- Additional productivity plugins

## License

MIT License - feel free to adapt and modify for your needs.

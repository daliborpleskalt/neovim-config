# Ultimate AI-Powered Neovim Setup - Complete Installation Guide

## Prerequisites

### System Requirements
- **macOS** (latest version recommended)
- **Homebrew** installed (`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`)
- **Terminal**: Warp (you're already using this ✅)
- **Git Client**: GitKraken (you're already using this ✅)

### API Keys Required
Before starting, obtain API keys from:
1. **Anthropic** (Claude): https://console.anthropic.com/ 
2. **Perplexity**: https://www.perplexity.ai/settings/api (you have Pro ✅)
3. **OpenAI** (optional): https://platform.openai.com/api-keys

## Step-by-Step Installation

### Step 1: Install Dependencies

```bash
# Run the provided installation script
chmod +x install.sh
./install.sh
```

This script installs:
- Neovim 0.11+
- Node.js and npm
- Essential tools (fd, ripgrep, fzf)
- TypeScript Language Server
- Angular Language Server  
- Rust and rust-analyzer
- MCP Hub
- Java LSP (if Java detected)

### Step 2: Backup Existing Configuration

```bash
# If you have an existing Neovim config, back it up
if [ -d "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
fi
```

### Step 3: Copy Configuration Files

```bash
# Create Neovim config directory
mkdir -p "$HOME/.config/nvim"

# Copy all configuration files
cp -r * "$HOME/.config/nvim/"

# Copy MCP servers configuration
cp mcpservers.json "$HOME/"
```

### Step 4: Setup Environment Variables

```bash
# Create environment file
cat > "$HOME/.env.nvim" << 'EOF'
# AI API Keys for Neovim
export ANTHROPIC_API_KEY="your-anthropic-key-here"
export OPENAI_API_KEY="your-openai-key-here"  
export PERPLEXITY_API_KEY="your-perplexity-key-here"

# Optional: Brave Search API for MCP
export BRAVE_API_KEY="your-brave-search-key-here"
EOF

# Edit the file with your actual API keys
nano "$HOME/.env.nvim"

# Add to your shell profile (since you're using Warp)
echo 'source ~/.env.nvim' >> ~/.zshrc
```

### Step 5: Customize MCP Configuration

Edit `~/mcpservers.json` to match your project directories:

```bash
nano ~/mcpservers.json
```

Update the `ALLOWED_DIRS` to your actual project paths:
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "ALLOWED_DIRS": "~/Projects,~/Development,~/YourProjectsPath"
      }
    }
  }
}
```

### Step 6: First Launch

```bash
# Source your environment
source ~/.zshrc

# Launch Neovim
nvim
```

**What to expect:**
- Lazy plugin manager will start installing plugins
- This may take 2-3 minutes on first launch
- Some plugins require compilation (Tree-sitter parsers, etc.)
- Wait for all installations to complete before closing

### Step 7: Verify Installation

After plugins are installed, test key features:

```bash
# Open Neovim with a test file
nvim test.ts
```

**Test checklist:**
- [ ] Catppuccin mocha theme loads
- [ ] LSP works (`:LspInfo` should show TypeScript server)
- [ ] Neo-tree opens with `<Space>e`
- [ ] Telescope works with `<Space>ff`
- [ ] AI chat works with `<Space>cc`

## Configuration Details

### File Structure
```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/             # Core configuration
│   │   ├── options.lua     # Neovim options & performance
│   │   ├── keymaps.lua     # All keybindings  
│   │   ├── lazy.lua        # Plugin manager setup
│   │   └── security.lua    # Security & API rate limiting
│   └── plugins/            # Plugin configurations
│       ├── ai-core.lua     # AI plugins (Avante, CodeCompanion, Parrot)
│       ├── colorscheme.lua # Catppuccin theme
│       ├── completion.lua  # nvim-cmp enhanced completion
│       ├── lsp.lua         # Language servers (TS, Rust, Java)
│       ├── neo-tree.lua    # File explorer
│       ├── telescope.lua   # Fuzzy finder
│       ├── treesitter.lua  # Syntax highlighting
│       └── ui.lua          # Status line & UI enhancements
```

### Security Features Implemented
- **API Rate Limiting**: 50 requests/hour for Claude, 100/hour for OpenAI
- **Request Logging**: All AI interactions logged to `~/.local/share/nvim/ai_audit.log`
- **Secure File Access**: MCP servers restricted to specified directories
- **Environment Isolation**: API keys in separate environment files

### Performance Optimizations
- **Memory Usage**: Disabled unused built-in plugins, optimized Tree-sitter
- **Startup Time**: Lazy loading for all plugins except essentials
- **Large Files**: Automatic feature disabling for files >100KB
- **LSP Efficiency**: Debounced requests, selective formatting

## Essential Keybindings

### File Operations
- `<Space>e` - Toggle Neo-tree file explorer
- `<Space>o` - Focus Neo-tree
- `<Space>ff` - Find files (Telescope)
- `<Space>fg` - Live grep search
- `<Space>fb` - Find open buffers
- `<Space>fr` - Recent files

### AI Features
- `<Space>aa` - Avante Ask (AI assistance)
- `<Space>ar` - Avante Refactor (visual selection)
- `<Space>cc` - CodeCompanion Chat
- `<Space>pp` - Parrot Chat (multi-provider)

### Buffer Management
- `Shift+L` - Next buffer
- `Shift+H` - Previous buffer
- `<Space>bd` - Delete current buffer

### LSP Features
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show hover documentation
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code actions
- `<Space>lf` - Format document

## Language-Specific Setup

### TypeScript/Angular Projects
The configuration automatically detects:
- `package.json` - TypeScript projects
- `angular.json` - Angular projects  
- `nx.json` - Nx monorepos

**Features enabled:**
- TypeScript LSP with inlay hints
- Angular Language Server for templates
- Auto-formatting on save
- Import organization

### Rust Projects
Detected by `Cargo.toml` files.

**Features:**
- rust-analyzer with clippy
- Automatic formatting
- Cargo integration
- Advanced diagnostics

### Java Projects
Detected by `pom.xml` or `build.gradle`.

**Features:**
- Eclipse JDT Language Server
- Maven/Gradle support
- Auto-completion and navigation

## AI Provider Configuration

### Claude (Primary - Recommended)
**Best for**: Complex reasoning, code refactoring, architectural decisions

Configuration in `ai-core.lua`:
```lua
claude = {
  endpoint = 'https://api.anthropic.com',
  model = 'claude-3-5-sonnet-20241022',
  temperature = 0,
  max_tokens = 4096,
}
```

### Perplexity (Fallback - Cost Effective)
**Best for**: Quick questions, research, documentation

Configuration:
```lua
perplexity = {
  api_key = os.getenv('PERPLEXITY_API_KEY'),
  endpoint = 'https://api.perplexity.ai/chat/completions',
  topic = {
    model = 'llama-3.1-sonar-large-128k-online',
  },
}
```

## Troubleshooting

### Common Issues

**1. Plugins not installing**
```bash
# Clear plugin cache and reinstall
rm -rf ~/.local/share/nvim/lazy
nvim --headless "+Lazy! sync" +qa
```

**2. LSP not working**
```bash
# Check Mason installations
:Mason
# In Neovim, reinstall language servers if needed
```

**3. AI features not responding**
- Verify API keys: `echo $ANTHROPIC_API_KEY`
- Check rate limits: `:messages` in Neovim
- Review audit log: `tail -f ~/.local/share/nvim/ai_audit.log`

**4. Performance issues**
```bash
# Check for large files causing slowdowns
:lua print(vim.fn.line('$'))
# Disable features for files >1000 lines if needed
```

### Getting Help

1. **Check Neovim health**: `:checkhealth`
2. **View plugin status**: `:Lazy`
3. **LSP information**: `:LspInfo`
4. **Error messages**: `:messages`

## Customization Tips

### Adding New Languages
1. Install LSP via Mason: `:Mason`
2. Add configuration in `plugins/lsp.lua`
3. Add Tree-sitter parser in `plugins/treesitter.lua`

### Custom Keybindings
Add to `config/keymaps.lua`:
```lua
vim.keymap.set('n', '<leader>custom', ':YourCommand<CR>', { desc = 'Description' })
```

### Theme Customization
Modify `plugins/colorscheme.lua` for Catppuccin customizations.

## Next Steps

1. **Explore AI Features**: Try different AI providers for various tasks
2. **Configure Projects**: Set up your specific project directories in MCP config
3. **Learn Keybindings**: Practice the ergonomic shortcuts daily
4. **Customize**: Adapt configurations to your specific workflow needs

## Workflow Integration

### With GitKraken
- Use Neovim for code editing and AI assistance
- Use GitKraken for Git operations and visual diff/merge
- AI can help with commit messages via CodeCompanion

### With Warp Terminal
- Use Warp for terminal operations
- Neovim handles editing with AI integration
- MCP servers can interact with file system and git

This setup gives you the best of both worlds: GitKraken's excellent Git UI, Warp's modern terminal features, and Neovim's unmatched editing power with cutting-edge AI integration.

---

**Congratulations! You now have a production-ready, AI-powered Neovim environment that rivals the best commercial AI IDEs while maintaining complete control and customization.**

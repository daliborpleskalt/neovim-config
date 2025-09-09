# TypeScript/Angular Linting & Formatting - Keymapping Reference

## 🎯 What is Linting & Formatting in Neovim?

This system provides **professional code quality tools** for TypeScript and Angular development with **eslint_d** and **prettierd** integration. It offers real-time linting, instant formatting, AI-powered error fixes, and seamless integration with your existing project configurations.

**Key capabilities:**
- **Real-time ESLint linting** with your project rules
- **Lightning-fast Prettier formatting** with daemon processes
- **AI-powered error resolution** with Avante integration
- **Professional diagnostics display** with Trouble.nvim
- **Auto-format on save** for TypeScript/JavaScript files
- **Project config detection** for .eslintrc and .prettierrc

## 🔧 Complete Keybinding Reference

### Core Formatting Commands
```vim
<leader>cf          " 🎨 Format current buffer with Prettier
<leader>cF          " 💾 Format and save buffer
```

**Usage examples:**
```vim
" In a TypeScript file with messy formatting:
<Space>cf           " Instantly formats with Prettier
<Space>cF           " Formats and saves in one command
```

### Linting & Error Fixing
```vim
<leader>cl          " 🔍 Lint current buffer with ESLint
<leader>cL          " 🔧 ESLint auto-fix all fixable issues
<leader>cai         " 🤖 AI fix diagnostics (Avante integration)
```

**Usage examples:**
```vim
" After making changes to TypeScript code:
<Space>cl           " Run linter to check for issues
<Space>cL           " Auto-fix all ESLint fixable problems
<Space>cai          " Get AI help for complex errors
```

### Diagnostics Navigation
```vim
]d                  " ➡️ Go to next diagnostic (error/warning)
[d                  " ⬅️ Go to previous diagnostic
<leader>cd          " 🔍 Show diagnostics for current line
```

**Usage examples:**
```vim
" Navigating through errors in your code:
]d                  " Jump to next ESLint error
[d                  " Jump back to previous warning
<Space>cd           " See detailed error message in popup
```

### Trouble.nvim - Enhanced Diagnostics
```vim
<leader>cd          " 🐛 Open diagnostics panel (Trouble)
<leader>cD          " 🐛 Show buffer diagnostics only
<leader>cs          " 🔍 Show symbols panel
<leader>cl          " 🔍 Show LSP definitions panel
<leader>cL          " 📋 Show location list
<leader>cQ          " 📋 Show quickfix list
```

**Usage examples:**
```vim
" Working with multiple errors across files:
<Space>cd           " Open Trouble diagnostics panel
# Navigate through all project errors visually
<Space>cD           " Focus only on current file errors
```

### Mason Tool Management
```vim
<leader>cm          " 🔨 Open Mason tool installer
```

**Usage examples:**
```vim
<Space>cm           " Open Mason to manage linters/formatters
# Install, update, or remove tools like eslint_d, prettierd
```

## 🎨 Master Workflow Patterns

### 1. The Code Quality Check Pattern

**Use when:** Before committing or during code review

```bash
# Step 1: Check current code quality
<Space>cl                    # Lint current file
# Review any errors or warnings highlighted

# Step 2: Auto-fix what's possible
<Space>cL                    # ESLint auto-fix
# ESLint fixes formatting, unused imports, etc.

# Step 3: Format for consistency
<Space>cf                    # Prettier format
# Ensures consistent code style

# Step 4: AI assistance for complex issues
<Space>cai                   # AI help with remaining errors
# Get intelligent suggestions for complex problems
```

**Example scenario:** "Cleaning up TypeScript service file before commit"
```bash
1. Open user.service.ts with linting errors
2. <Space>cl → Shows 5 ESLint warnings
3. <Space>cL → Auto-fixes 3 warnings (unused imports, semicolons)
4. <Space>cf → Formats code consistently
5. <Space>cai → AI suggests fix for remaining async/await warning
```

### 2. The Error Investigation Pattern

**Use when:** Debugging TypeScript/ESLint errors you don't understand

```bash
# Step 1: Navigate to error
]d                          # Jump to next diagnostic
# Position cursor on the problematic line

# Step 2: Get detailed error info
<Space>cd                   # Show diagnostic details
# Read full error message and context

# Step 3: AI-powered analysis
<Space>cai                  # Ask AI for help
# Get explanation and fix suggestions

# Step 4: Apply fix and verify
# Make changes based on AI suggestion
<Space>cl                   # Re-lint to verify fix
```

**Example scenario:** "Complex TypeScript generic error"
```bash
1. ]d → Jump to "Type 'unknown' is not assignable to type 'User'" error
2. <Space>cd → See full error with context
3. <Space>cai → AI explains: "Need type guard or assertion for API response"
4. Apply AI suggestion, <Space>cl → Error resolved
```

### 3. The File Cleanup Pattern

**Use when:** Working with messy or legacy code files

```bash
# Step 1: Open problematic file
# TypeScript file with formatting and linting issues

# Step 2: Format first
<Space>cf                   # Clean up formatting
# Makes it easier to see actual logic issues

# Step 3: Auto-fix obvious problems  
<Space>cL                   # ESLint auto-fix
# Removes unused variables, fixes imports, etc.

# Step 4: Review remaining issues
<Space>cd                   # Open diagnostics panel
# See overview of all remaining problems

# Step 5: AI-assisted cleanup
<Space>cai                  # Get AI help for each issue
# Work through complex problems systematically

# Step 6: Final save
<Space>cF                   # Format and save
```

**Example scenario:** "Refactoring legacy Angular component"
```bash
1. Open legacy-user.component.ts (50+ ESLint warnings)
2. <Space>cf → Clean formatting makes structure clearer
3. <Space>cL → Auto-fixes 30+ simple issues
4. <Space>cd → Shows remaining 15 complex issues
5. <Space>cai → AI helps modernize deprecated API calls
6. <Space>cF → Save clean, modern component
```

### 4. The Real-Time Development Pattern

**Use when:** Normal TypeScript/Angular development workflow

```bash
# Development flow with continuous quality checks

# While coding:
# - Real-time linting shows issues as you type
# - Red/yellow underlines indicate problems

# Quick fixes during development:
]d [d                       # Navigate between issues quickly
<Space>cd                   # Quick error details
<Space>cL                   # Quick auto-fix

# Before saving important changes:
<Space>cf                   # Format current work
<Space>cl                   # Final lint check
<Space>cF                   # Format and save
```

**Example scenario:** "Daily Angular development"
```bash
1. Working on user-profile.component.ts
2. Notice red underline on import statement
3. <Space>cd → "Module not found" error
4. Fix import path
5. ]d → Jump to next warning about unused variable
6. Remove unused code
7. <Space>cF → Format and save clean code
```

### 5. The Project-Wide Quality Pattern

**Use when:** Ensuring code quality across entire project

```bash
# Step 1: Open Trouble diagnostics
<Space>cd                   # Project-wide diagnostics view
# See all ESLint errors across all files

# Step 2: Work through files systematically
# Click on files in Trouble panel to jump to issues
<Space>cL                   # Auto-fix each file
<Space>cf                   # Format each file

# Step 3: Focus on remaining manual fixes
# Use AI assistance for complex issues
<Space>cai                  # AI help for tricky problems

# Step 4: Verify project health
<Space>cd                   # Check Trouble panel again
# Should show significantly fewer issues
```

**Example scenario:** "Pre-release code quality sweep"
```bash
1. <Space>cd → Trouble shows 127 issues across 23 files
2. Work through each file:
   - <Space>cL → Auto-fix simple issues
   - <Space>cai → AI help for complex ones
3. <Space>cd → Now shows 12 remaining issues
4. Manual review and fixes for final items
5. Clean codebase ready for release
```

## 🤖 AI Integration Strategies

### 1. Smart Error Resolution

**Context-Aware AI Prompts:**
```vim
# Position cursor on error line, then:
<Space>cai                  # AI gets full context:
                           # - Current line with error
                           # - Surrounding code context
                           # - ESLint error message
                           # - File type (TypeScript/Angular)
```

**AI provides:**
- Explanation of the error
- Multiple fix options
- Best practices context
- Code examples

### 2. Learning from AI Fixes

**Pattern Recognition:**
```vim
# Use AI fixes as learning opportunities:
<Space>cai                  # Get AI fix suggestion
# Read explanation carefully
# Apply fix manually to understand the change
<Space>cl                   # Verify fix works
```

### 3. Batch Problem Solving

**Complex Issue Resolution:**
```vim
# For files with many issues:
<Space>cd                   # Open Trouble diagnostics
# Select related errors (e.g., all async/await issues)
<Space>cai                  # Ask AI for pattern-based solutions
# Apply systematic fixes across similar problems
```

## 🚨 Troubleshooting

### Common Issues and Solutions

#### ESLint Not Running
```bash
# Check if ESLint config exists
:!ls .eslintrc*
:!ls eslint.config.*

# Verify eslint_d is installed
:Mason

# Manual linting test
:!npx eslint --version
```

#### Prettier Not Formatting
```bash
# Check if Prettier config exists  
:!ls .prettierrc*
:!ls prettier.config.*

# Verify prettierd is installed
:Mason

# Manual formatting test
:!npx prettier --version
```

#### Diagnostics Not Showing
```bash
# Check diagnostic configuration
:lua vim.diagnostic.config()

# Verify nvim-lint setup
:checkhealth lint

# Check LSP status
:LspInfo
```

#### Auto-format Not Working
```bash
# Check if auto-format is enabled
:lua print(require('config.typescript-linters-formatters-config').auto_format_enabled)

# Toggle auto-format
:lua require('config.typescript-linters-formatters-config').toggle_auto_format()
```

### Performance Optimization

**For Large Projects:**
```vim
# Disable real-time linting if too slow
:lua require('lint').linters_by_ft = {}

# Format only specific file types
# Edit conform.nvim config to limit formatters

# Use buffer-specific diagnostics
<leader>cD                  # Focus on current buffer only
```

**Memory Management:**
```vim
# Clear diagnostics if too many
:lua vim.diagnostic.reset()

# Restart eslint_d daemon if stuck
:!pkill -f eslint_d
```

## 💡 Pro Tips & Advanced Usage

### 1. Custom Formatting Rules

**Project-Specific Settings:**
```json
// .prettierrc.json in your project
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

**Override for Specific Files:**
```vim
# Format with different rules
:lua require('conform').format({ formatters = { 'prettierd' }, timeout_ms = 5000 })
```

### 2. Team Collaboration

**Consistent Team Standards:**
```bash
# Ensure team uses same tools
npm install --save-dev eslint prettier

# Share configurations
git add .eslintrc.json .prettierrc.json
git commit -m "Add linting and formatting configs"
```

**Code Review Integration:**
```vim
# Before submitting PR
<Space>cd                   # Check all diagnostics
<Space>cL                   # Auto-fix everything possible
<Space>cF                   # Format and save all files
```

### 3. Productivity Shortcuts

**Quick File Cleanup:**
```vim
# Create custom command for full cleanup
:command! CleanFile lua vim.cmd('normal <leader>cL'); vim.cmd('normal <leader>cF')

# Use it on any messy file
:CleanFile
```

**Batch Operations:**
```vim
# Format multiple files
:argdo lua require('config.typescript-linters-formatters-config').format_buffer()
:argdo write
```

### 4. Integration with Git

**Pre-commit Hooks:**
```bash
# In your project's .git/hooks/pre-commit
#!/bin/sh
# Format and lint staged files
npm run lint:fix
npm run format
```

**Commit Message Integration:**
```vim
# Before committing
<Space>cd                   # Verify no critical errors
<Space>cF                   # Final format and save
# Then use your git workflow
```

## 🎯 Success Indicators

### Beginner Level
- [ ] Can format TypeScript files with `<Space>cf`
- [ ] Uses auto-fix for simple ESLint issues with `<Space>cL`
- [ ] Navigates diagnostics with `]d` and `[d`
- [ ] Shows error details with `<Space>cd`

### Intermediate Level
- [ ] Uses Trouble for project-wide diagnostic management
- [ ] Integrates AI assistance for complex error resolution
- [ ] Sets up auto-format on save for consistent code style
- [ ] Understands project config detection and customization

### Advanced Level
- [ ] Creates custom formatting workflows for team standards
- [ ] Optimizes linting performance for large projects
- [ ] Integrates with CI/CD and pre-commit hooks
- [ ] Mentors others in professional code quality practices

### Expert Level
- [ ] Contributes to team linting and formatting standards
- [ ] Creates custom ESLint rules for project-specific needs
- [ ] Develops automated code quality workflows
- [ ] Leads adoption of AI-assisted code quality practices

## 🚀 Your Professional TypeScript Development

This linting and formatting system transforms your TypeScript/Angular development into a **professional, efficient, and high-quality process**. You now have:

- **⚡ Lightning-Fast Tools**: eslint_d and prettierd provide instant feedback
- **🤖 AI-Powered Assistance**: Smart error resolution with contextual understanding
- **🔧 Seamless Integration**: Works with your existing project configurations
- **📊 Professional Diagnostics**: Visual error management with Trouble.nvim
- **🎯 Consistent Quality**: Auto-formatting and linting enforce standards
- **🚀 Productivity Boost**: Catch errors early, fix issues quickly

**Remember:** The goal is to **write better code faster** while **maintaining consistency** across your projects. Use these tools to **elevate your code quality** and **speed up your development workflow**!

Your TypeScript/Angular development just became incredibly professional and efficient. Happy coding with perfect code quality! 🎯✨

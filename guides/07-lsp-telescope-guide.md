# LSP & Telescope - Navigation and Code Intelligence Guide

## 🎯 Language Server Protocol (LSP) - Your Code Intelligence Engine

LSP provides **intelligent code features** that understand your programming language:
- **Go to definition** - Jump to where functions/variables are defined
- **Find references** - See all places where code is used
- **Hover information** - Get documentation and type info
- **Code actions** - Quick fixes and refactoring suggestions
- **Diagnostics** - Real-time error and warning detection

## 🔍 Telescope - Your Fuzzy Finder Superpower

Telescope provides **fast, fuzzy search** across your entire codebase:
- **File finding** - Locate any file instantly
- **Content search** - Find text across all files
- **Buffer management** - Switch between open files
- **Git integration** - Search git files, commits, branches

## 🚀 Your LSP Keymaps

### Navigation Commands
```bash
gd              Go to definition
gD              Go to declaration  
gi              Go to implementation
gr              Go to references
K               Show hover documentation (type info, docs)
```

### Code Actions
```bash
<Space>rn       Rename symbol (variable, function, etc.)
<Space>ca       Show code actions (fixes, refactoring)
<Space>lf       Format document
<Space>d        Show diagnostic popup (error details)
```

### Diagnostic Navigation
```bash
[d              Go to previous diagnostic (error/warning)
]d              Go to next diagnostic (error/warning)
```

## 🚀 Your Telescope Keymaps

### File Operations
```bash
<Space>ff       Find files (fuzzy search by filename)
<Space>fg       Live grep (search text content across files)
<Space>fb       Find buffers (switch between open files)
<Space>fh       Find help tags (Neovim documentation)
<Space>fr       Find recent files (oldfiles)
<Space>fc       Find colorschemes
```

### Advanced Features
```bash
# In Telescope picker:
<C-j>/<C-k>     Navigate up/down in results
<CR>            Open selected file
<C-x>           Open in horizontal split
<C-v>           Open in vertical split  
<C-t>           Open in new tab
<C-c>           Close Telescope
```

## 💡 How to Use LSP Effectively

### 1. Code Exploration Pattern

**Understanding unfamiliar code**:
```bash
# Start with the main function/component
K               # Get hover info - see what this function does
gd              # Go to definition to see implementation
gr              # Find all references to understand usage
<C-o>           # Jump back to where you started
```

**Example workflow**: "Understanding a React component"
```typescript
function UserProfile({ userId }: Props) {
  // 1. Position cursor on UserProfile
  // 2. K → see component documentation
  // 3. gd → see the Props interface definition
  // 4. gr → find all places UserProfile is used
  // 5. <C-o> → return to original location
}
```

### 2. Code Navigation Mastery

**Following the code flow**:
```bash
# Tracing function calls:
1. Position cursor on function call
2. gd           # Jump to function definition
3. Read implementation
4. gd           # Jump deeper into nested calls
5. <C-o>        # Jump back when done
6. <C-i>        # Jump forward again if needed
```

**Multi-language navigation**:
```typescript
// TypeScript/React example:
const user = await fetchUser(userId);
//                  ↑ cursor here
// gd → see fetchUser implementation
// gi → see interface definition
// gr → find all fetchUser usage
```

### 3. Error Resolution Workflow

**Using diagnostics effectively**:
```bash
# When you see red squiggles:
]d              # Jump to next error
<Space>d        # See detailed error message
<Space>ca       # Check available code actions/fixes
K               # Get context about the symbol
```

**Example scenario**: "TypeScript type error"
```typescript
// Error: Property 'name' does not exist on type 'User'
const userName = user.name;
//                    ↑ cursor here

# Workflow:
# 1. <Space>d → see full error message
# 2. gd on 'user' → see User type definition
# 3. <Space>ca → check for quick fixes
# 4. Fix the type or property access
```

### 4. Refactoring with LSP

**Safe refactoring workflow**:
```bash
# Renaming variables/functions:
1. Position cursor on symbol to rename
2. <Space>rn    # Start rename operation
3. Type new name
4. <CR>         # Apply rename across all files

# Code actions for improvements:
1. Position cursor on code that needs improvement
2. <Space>ca    # Show available code actions
3. Select action from menu
4. Review changes
```

## 💡 How to Use Telescope Effectively

### 1. Lightning-Fast File Access

**Finding files by name**:
```bash
<Space>ff       # Open file finder
# Type partial filename (fuzzy matching):
"usr" → finds "UserProfile.tsx", "user.model.ts", etc.
"tcfg" → finds "tailwind.config.js"
"appts" → finds "app.test.ts"
```

**Pro tips for file finding**:
```bash
# Use abbreviations:
"rc" → finds "README.md", "React components"
"cfg" → finds config files
"test" → finds all test files
"comp" → finds component files

# Use path hints:
"src/comp" → files in src/components/
"spec" → test/spec files
```

### 2. Content Search Mastery

**Finding text across your codebase**:
```bash
<Space>fg       # Open live grep
# Search for:
"TODO" → find all TODO comments
"useState" → find React hook usage
"async function" → find async functions
"interface User" → find User type definitions
```

**Advanced search patterns**:
```bash
# Use regex patterns in live grep:
"function \w+User" → find functions containing "User"
"import.*react" → find React imports
"export.*interface" → find exported interfaces
```

### 3. Buffer Management

**Switching between open files**:
```bash
<Space>fb       # Show open buffers
# Quick switching:
- See recently used files
- Jump between related files
- Close unused buffers
```

### 4. Recent Files Workflow

**Accessing recent work**:
```bash
<Space>fr       # Show recent files (oldfiles)
# Quickly return to:
- Files you worked on yesterday
- Recently closed files
- Files from previous sessions
```

## 🎨 Advanced LSP + Telescope Workflows

### 1. The Investigation Workflow

**Deep-diving into unfamiliar code**:
```bash
# Step 1: Find the entry point
<Space>ff → "main" or "index" → <CR>

# Step 2: Explore with LSP
K               # Understand what you're looking at
gd              # Follow the trail
gr              # See usage patterns

# Step 3: Search for related code
<Space>fg → search for key terms
<Space>ff → find related files

# Step 4: Build mental model
# Open multiple files in splits
# Use <C-o>/<C-i> to navigate back and forth
```

### 2. The Bug Hunt Workflow

**Systematic debugging approach**:
```bash
# Step 1: Find the error location
]d              # Jump to next diagnostic
<Space>d        # Read error details

# Step 2: Trace the code path
gd              # Go to definition
gr              # Find all references
<Space>fg → search error message or related terms

# Step 3: Find similar patterns
<Space>fg → search for similar code patterns
<Space>ff → find related test files

# Step 4: Verify the fix
<Space>ca       # Check available code actions
Apply fix and test
```

### 3. The Feature Development Workflow

**Building new features efficiently**:
```bash
# Step 1: Research existing patterns
<Space>fg → search for similar features
<Space>ff → find related component files

# Step 2: Understand the architecture  
gd/gr → trace through existing code
K → understand interfaces and types

# Step 3: Create new files in context
<Space>e → Neo-tree for file creation
Follow existing patterns

# Step 4: Implement with LSP guidance
Use LSP for type checking and completion
<Space>ca → quick fixes and improvements
```

### 4. The Refactoring Workflow

**Large-scale code improvements**:
```bash
# Step 1: Find all instances
<Space>fg → search for code to refactor
gr → find all references

# Step 2: Understand impact
<Space>ff → find test files
<Space>fg → search for related patterns

# Step 3: Plan the refactoring
Use multiple splits to see all affected files
Document the plan

# Step 4: Execute safely
<Space>rn → rename symbols
<Space>ca → use code actions for transformations
Test incrementally
```

## 🔧 Integration Patterns

### 1. LSP + Telescope Combo

**Finding and understanding code**:
```bash
<Space>fg → "fetchUser"     # Find all fetchUser calls
<CR>                        # Jump to first result
gd                          # Go to implementation
gr                          # See all usage
<Space>fb                   # Switch between open files
```

### 2. LSP + Neo-tree + AI

**Complete code exploration**:
```bash
<Space>e                    # Open file tree for context
<Space>ff → filename        # Find specific file
gd                          # Explore with LSP
<Space>aa                   # Ask AI about what you found
```

### 3. Telescope + AI Research

**Learning from existing code**:
```bash
<Space>fg → "pattern name"  # Find examples in codebase
Study implementations
<Space>cc                   # Discuss patterns with AI
Apply learnings to new code
```

## 🎯 Language-Specific Tips

### TypeScript/JavaScript
```bash
# Type exploration:
K               # See type information
gd              # Go to type definition
gi              # Go to interface implementation

# Error resolution:
<Space>ca       # TypeScript quick fixes
<Space>d        # Detailed type errors
```

### React
```bash
# Component exploration:
gd on component → see component definition
gr on props → find all prop usage
<Space>fg → "useState" → find hook patterns
```

### Rust
```bash
# Ownership tracking:
gr              # Find all variable usage
K               # See type and lifetime info
<Space>ca       # Rust-specific code actions
```

### Java
```bash
# Class navigation:
gd              # Go to class definition
gi              # Go to interface implementation
<Space>fg → "extends" → find inheritance patterns
```

## 🚀 Pro Tips and Tricks

### 1. LSP Optimization
- **Use hover (K) liberally** - It's fast and informative
- **Master the jump list** - `<C-o>`/`<C-i>` for navigation history
- **Rename fearlessly** - `<Space>rn` works across all files
- **Trust code actions** - `<Space>ca` often has perfect suggestions

### 2. Telescope Mastery
- **Learn fuzzy patterns** - "usrcmp" finds "UserComponent.tsx"
- **Use live grep smartly** - Search for concepts, not just text
- **Combine with other tools** - Find with Telescope, explore with LSP
- **Remember recent files** - `<Space>fr` is often faster than browsing

### 3. Workflow Optimization
- **Open related files in splits** - See context while working
- **Use marks for important locations** - `ma`, `'a` for bookmarks
- **Combine tools strategically** - Each tool has its strength
- **Practice the patterns** - Speed comes from muscle memory

### 4. Troubleshooting

**Common LSP issues**:
```bash
# LSP not working:
:LspInfo        # Check LSP status
:Mason          # Install/update language servers
:checkhealth    # Overall health check

# Slow responses:
Restart LSP server
Check file size (LSP struggles with huge files)
Update language server via Mason
```

**Telescope performance**:
```bash
# Slow searches:
Exclude large directories (.git, node_modules)
Use more specific search terms
Consider file ignore patterns
```

## 🎯 Practice Exercises

### Week 1: Basic Navigation
- [ ] Find any file in under 5 seconds using `<Space>ff`
- [ ] Jump to definition and back using `gd` and `<C-o>`
- [ ] Find all references of a function using `gr`
- [ ] Search for text across files using `<Space>fg`

### Week 2: Code Understanding
- [ ] Trace through a complex function using LSP navigation
- [ ] Find all TODO comments in your codebase
- [ ] Understand a new component by exploring its props and usage
- [ ] Use hover documentation to learn about unfamiliar APIs

### Week 3: Refactoring
- [ ] Safely rename a variable used across multiple files
- [ ] Find and fix a TypeScript type error using LSP
- [ ] Use code actions to improve code quality
- [ ] Search for and update deprecated API usage

### Week 4: Advanced Workflows
- [ ] Investigate a bug using systematic LSP + Telescope approach
- [ ] Implement a feature by studying existing similar code
- [ ] Refactor a component by understanding all its usage
- [ ] Document your findings using AI assistance

Remember: **LSP and Telescope are your code navigation superpowers**. Master them to move through code at the speed of thought, understand complex systems quickly, and make changes with confidence! 🎯⚡

# Neo-tree - Complete File Explorer Guide

## 🌳 What is Neo-tree?

Neo-tree is your **modern file explorer** for Neovim, providing:
- **Visual file navigation** - Tree-style directory browsing
- **Git integration** - See git status directly in the file tree
- **Advanced file operations** - Create, delete, rename, move files
- **Multiple views** - File system, buffers, and git status

## 🚀 Your Neo-tree Keymaps

### Primary Commands
```bash
<Space>e        Toggle Neo-tree (open/close)
<Space>o        Focus Neo-tree (switch to tree window)
```

### Navigation in Neo-tree
```bash
# Basic Movement (in Neo-tree window)
j / k           Move down/up in tree
h / l           Collapse/expand directories  
<CR>            Open file/expand directory
<Tab>           Preview file (keep tree focus)

# Tree Operations
o               Open file
O               Open file without losing tree focus
t               Open in new tab
s               Open in horizontal split
S               Open in vertical split

# Directory Navigation  
<BS>            Go up one directory (parent)
.               Set current directory as root
/               Search/filter files
```

### File Operations
```bash
a               Add file/directory (end with / for directory)
A               Add directory
d               Delete file/directory
r               Rename file/directory  
c               Copy file/directory
x               Cut file/directory
p               Paste file/directory
y               Copy name to clipboard
Y               Copy relative path to clipboard
```

### Display & Filtering
```bash
H               Toggle hidden files (.dotfiles)
I               Toggle gitignored files
R               Refresh tree
?               Show help (all keybindings)
q               Close Neo-tree
```

## 🎯 How to Use Neo-tree Effectively

### 1. Basic File Navigation

**Opening Neo-tree**:
```bash
<Space>e        # Toggle - opens if closed, closes if open
<Space>o        # Focus - switches to tree window if open
```

**Moving around**:
```bash
# Navigate with vim keys
j               # Move down to next file/folder
k               # Move up to previous file/folder  
<CR>            # Open file or expand/collapse folder
h               # Collapse current folder
l               # Expand current folder
```

**Opening files**:
```bash
<CR>            # Open and switch to file
o               # Open and switch to file
O               # Open but keep focus in Neo-tree
<Tab>           # Preview file (quick look without switching)
s               # Open in horizontal split
S               # Open in vertical split  
t               # Open in new tab
```

### 2. File Management Operations

**Creating files and directories**:
```bash
a               # Add new file (type filename)
                # Add trailing / for directory: newfolder/
A               # Add directory (prompts for name)

# Examples:
a → component.tsx           # Creates new file
a → components/             # Creates new directory
A → utils                   # Creates new directory
```

**File operations**:
```bash
r               # Rename file/directory
d               # Delete file/directory (with confirmation)
c               # Copy file/directory  
x               # Cut file/directory
p               # Paste (use after copy or cut)

# Copy file paths:
y               # Copy filename to clipboard
Y               # Copy relative path to clipboard
```

### 3. Advanced Navigation

**Directory operations**:
```bash
<BS>            # Go to parent directory
.               # Set current directory as tree root
/               # Search/filter files in tree
```

**View toggles**:
```bash
H               # Toggle hidden files (.env, .git, etc.)
I               # Toggle gitignored files  
R               # Refresh tree (reload from filesystem)
```

## 🎨 Advanced Neo-tree Workflows

### 1. Project Exploration Workflow

**When starting work on a project**:
```bash
1. <Space>e     # Open Neo-tree
2. Navigate to project root
3. .           # Set as root (focuses view)
4. H           # Show hidden files if needed
5. Explore structure with j/k and <CR>
```

**Quick file access pattern**:
```bash
<Space>e       # Open tree
/myfile        # Search for specific file
<CR>           # Open file
<Space>e       # Close tree (or keep open)
```

### 2. File Management Workflow

**Creating new feature structure**:
```bash
1. <Space>e                    # Open Neo-tree
2. Navigate to src/components/
3. a → UserProfile/            # Create directory
4. <CR>                        # Enter directory
5. a → index.ts               # Create index file
6. a → UserProfile.tsx        # Create component file
7. a → UserProfile.test.tsx   # Create test file
8. a → UserProfile.styles.css # Create styles
```

**Organizing files**:
```bash
1. Select file with j/k
2. x                          # Cut file
3. Navigate to target directory
4. p                          # Paste file
```

### 3. Multi-file Operations

**Working with multiple files**:
```bash
# Open related files in splits:
1. <Space>e                   # Open tree
2. Navigate to component.tsx
3. s                          # Open in horizontal split  
4. Navigate to component.test.tsx
5. S                          # Open in vertical split
6. Navigate to component.css
7. t                          # Open in new tab
```

**Compare files side by side**:
```bash
1. Open first file with s (horizontal split)
2. Open second file with S (vertical split)
3. Use <C-w>h/j/k/l to navigate between windows
```

## 🔍 Git Integration Features

Neo-tree shows **git status** directly in the tree:

### Git Status Indicators
```bash
✓ M             Modified files (changed)
✓ A             Added files (staged)  
✓ D             Deleted files
✓ R             Renamed files
✓ ??            Untracked files (new)
✓ !             Ignored files
```

### Working with Git Files
```bash
# Visual git workflow:
1. <Space>e                   # Open Neo-tree
2. See modified files (M indicator)
3. Open files to review changes
4. Use GitKraken for commits (your preferred tool)
```

## 🛠️ Integration with Your Workflow

### 1. With Telescope (File Finding)

**Complementary usage**:
```bash
# Use Neo-tree for: Structure exploration, file management
<Space>e       # Explore project structure
<Space>ff      # Quick file finding with Telescope

# Use Telescope for: Fast file access, searching
<Space>ff      # Find files by name quickly  
<Space>fg      # Search content across files
```

### 2. With AI Tools (Context Gathering)

**Gather context for AI**:
```bash
1. <Space>e                   # Open Neo-tree
2. Navigate to related files
3. Open multiple files with splits
4. <Space>aa                  # Ask Avante about the structure
5. <Space>cc                  # Discuss architecture with CodeCompanion
```

### 3. With LSP (Code Navigation)

**Navigate code relationships**:
```bash
1. Use gd (go to definition) from LSP
2. <Space>e                   # Open Neo-tree to see file location  
3. Navigate to related files in tree
4. Use gr (references) to see usage
```

## 🎯 Productivity Patterns

### 1. The Explorer Pattern

**When learning a new codebase**:
```bash
<Space>e       # Open Neo-tree
.              # Set project root
H              # Show hidden files (see config files)
```

**Navigate systematically**:
```bash
src/           # Start with source code
├── components/ # Understand component structure
├── utils/     # Check utility functions
├── types/     # Review type definitions  
└── tests/     # See testing patterns
```

### 2. The Feature Development Pattern

**Creating new feature**:
```bash
1. <Space>e                   # Open tree
2. Navigate to features/
3. a → user-profile/         # Create feature directory
4. <CR>                      # Enter directory
5. Create structure:
   a → index.ts              # Barrel exports
   a → UserProfile.tsx       # Main component
   a → hooks/                # Custom hooks
   a → types/                # Type definitions
   a → __tests__/           # Test files
```

### 3. The Refactoring Pattern

**Moving and organizing files**:
```bash
1. Identify files to move (visual in Neo-tree)
2. x (cut) files that need moving
3. Navigate to new location  
4. p (paste) to move
5. Update imports (use LSP or AI assistance)
```

### 4. The Debugging Pattern

**Finding related files during debugging**:
```bash
1. Error occurs in ComponentA
2. <Space>e                  # Open Neo-tree
3. Navigate to ComponentA location
4. Look at surrounding files:
   - Parent components
   - Sibling components  
   - Related utilities
   - Test files for patterns
```

## 🔧 Customization and Tips

### Neo-tree Window Management

**Keep Neo-tree open vs. toggling**:
```bash
# Toggle approach (clean workspace):
<Space>e       # Open when needed
<Space>e       # Close when done

# Persistent approach (always visible):
<Space>e       # Open once
<Space>o       # Focus when needed
<C-w>l         # Return to main window
```

### Efficient File Creation

**Batch file creation**:
```bash
# Create component with all related files:
a → Component.tsx
a → Component.test.tsx
a → Component.styles.css
a → Component.stories.tsx
a → index.ts
```

**Directory structure templates**:
```bash
# Feature directory structure:
feature-name/
├── index.ts              # Exports
├── FeatureName.tsx       # Main component
├── hooks/                # Custom hooks
│   └── useFeatureName.ts
├── components/           # Sub-components
│   └── SubComponent.tsx
├── types/               # Type definitions
│   └── index.ts
└── __tests__/           # Tests
    └── FeatureName.test.tsx
```

## 🚀 Pro Tips

### 1. Speed Navigation
- **Learn the tree structure**: Memorize common paths
- **Use search (/)**: Quick filtering for large directories  
- **Set root (.)**: Focus on current working area
- **Use preview (<Tab>)**: Quick file inspection

### 2. File Management Efficiency
- **Plan before creating**: Think about structure first
- **Use consistent naming**: Follow project conventions
- **Organize as you go**: Don't let files accumulate messily
- **Use copy/cut/paste**: Move files efficiently

### 3. Integration Mastery
- **Combine with Telescope**: Tree for structure, search for speed
- **Use with Git tools**: Visual status, external commits
- **Coordinate with AI**: Show context, discuss structure
- **LSP integration**: Navigate, then explore in tree

### 4. Workflow Optimization
- **Keep tree open**: For structure-heavy work
- **Toggle frequently**: For focused coding sessions
- **Use splits effectively**: Multiple files from tree
- **Preview liberally**: Quick inspection without switching

## 🎓 Learning Path

### Week 1: Basic Navigation
- Master j/k movement
- Learn <CR> for opening files/folders
- Practice <Space>e toggle

### Week 2: File Operations  
- Create files/directories (a, A)
- Rename and delete (r, d)
- Copy and paste (c, x, p)

### Week 3: Advanced Features
- Use search/filtering (/)
- Master hidden files toggle (H)
- Learn split operations (s, S, t)

### Week 4: Workflow Integration
- Combine with Telescope
- Use with AI tools for context
- Develop personal patterns

Remember: **Neo-tree is your visual map of the codebase**. Use it to understand structure, manage files efficiently, and provide context for your AI-powered development workflow! 🌳✨

# Complete Keymap Reference - Your Neovim Cheat Sheet

## 🎯 Essential Vim Motions (Muscle Memory First!)

### Basic Movement
```bash
h j k l         Left, Down, Up, Right (arrow keys disabled - learn these!)
w b e           Word forward, back, end
W B E           WORD forward, back, end (whitespace delimited)  
0 ^ $           Line start, first non-blank, line end
gg G            File start, file end
{number}G       Go to line number
{ }             Paragraph up, down
( )             Sentence up, down
```

### Essential Text Objects
```bash
iw aw           Inner word, around word
i" a"           Inner quotes, around quotes  
i' a'           Inner single quotes, around single quotes
i( a( i) a)     Inner parentheses, around parentheses
i[ a[ i] a]     Inner brackets, around brackets
i{ a{ i} a}     Inner braces, around braces
it at           Inner tag, around tag
ip ap           Inner paragraph, around paragraph
```

### Core Operations
```bash
d{motion}       Delete motion (dw, dd, d$)
c{motion}       Change motion (cw, cc, c$)
y{motion}       Yank motion (yw, yy, y$)
p P             Paste after, paste before
u <C-r>         Undo, redo
. ,             Repeat last change, repeat last f/F/t/T
```

## 🚀 Your Custom Leader Key Mappings (Space = Leader)

### File Operations
```bash
<Space>w        Save file (:w)
<Space>q        Quit (:q)  
<Space>Q        Force quit all (:qa!)
```

### Navigation & Search
```bash
<Space>ff       Find files (Telescope)
<Space>fg       Live grep search (Telescope)
<Space>fb       Find buffers (Telescope)
<Space>fr       Recent files (Telescope)
<Space>fh       Help tags (Telescope)
<Space>fc       Colorschemes (Telescope)

<Space>e        Toggle Neo-tree file explorer
<Space>o        Focus Neo-tree (switch to tree window)
```

### AI Assistance (Triple AI Setup)
```bash
# Avante.nvim (Cursor-like inline AI)
<Space>aa       Avante Ask - AI help with current context
<Space>ae       Avante Edit - AI edit selected code (visual mode)
<Space>ac       Avante Chat - AI chat sidebar
<Space>at       Avante Toggle - Toggle interface

# CodeCompanion.nvim (Conversational AI)  
<Space>cc       CodeCompanion Chat - Deep AI conversations
<Space>ce       CodeCompanion Edit - AI transform selection (visual mode)
<Space>cm       CodeCompanion Actions - Available AI actions menu

# Parrot.nvim (Multi-provider AI)
<Space>pp       Parrot Chat - Choose AI provider (Claude/GPT-4/Perplexity)
<Space>pr       Parrot Rewrite - AI rewrite selection (visual mode)
```

### LSP (Language Server Features)
```bash
gd              Go to definition
gD              Go to declaration
gi              Go to implementation  
gr              Go to references
K               Show hover documentation

<Space>rn       Rename symbol across project
<Space>ca       Code actions (fixes, refactoring)
<Space>lf       Format document
<Space>d        Show diagnostic details (error popup)

[d              Previous diagnostic (error/warning)
]d              Next diagnostic (error/warning)
```

### Buffer & Window Management
```bash
<S-l>           Next buffer
<S-h>           Previous buffer
<Space>bd       Delete buffer
<Space>ba       Delete all buffers except current

<C-h>           Move to left window
<C-j>           Move to down window
<C-k>           Move to up window
<C-l>           Move to right window

<C-Up>          Resize window smaller
<C-Down>        Resize window bigger
<C-Left>        Resize window narrower
<C-Right>       Resize window wider
```

### Visual Mode Operations
```bash
<               Indent left (visual mode)
>               Indent right (visual mode)
<A-j>           Move selection down (visual mode)
<A-k>           Move selection up (visual mode)
```

### Search & Replace  
```bash
<leader>nh      Clear search highlighting
/{pattern}      Search forward
?{pattern}      Search backward
n               Next search result
N               Previous search result
*               Search word under cursor forward
#               Search word under cursor backward
```

## 🎨 Neo-tree File Explorer Commands

### Basic Navigation (in Neo-tree window)
```bash
j k             Move down/up
h l             Collapse/expand directories
<CR>            Open file/directory
<Tab>           Preview file (keep tree focus)
<BS>            Go to parent directory
.               Set current directory as root
/               Search/filter files
```

### File Operations
```bash
a               Add file (end with / for directory)
A               Add directory  
d               Delete file/directory
r               Rename file/directory
c               Copy file/directory
x               Cut file/directory
p               Paste file/directory
y               Copy name to clipboard
Y               Copy relative path to clipboard
```

### View Controls
```bash
H               Toggle hidden files (.dotfiles)
I               Toggle gitignored files
R               Refresh tree
?               Show help
q               Close Neo-tree
```

### File Opening Options
```bash
o               Open file and switch to it
O               Open file but keep focus in Neo-tree
s               Open in horizontal split
S               Open in vertical split
t               Open in new tab
```

## 🔍 Telescope Picker Commands

### In Telescope Interface
```bash
<C-j> <C-k>     Navigate down/up in results
<CR>            Open selected file
<C-x>           Open in horizontal split
<C-v>           Open in vertical split
<C-t>           Open in new tab
<C-c>           Close Telescope
<C-u>           Clear prompt
```

## 🤖 AI-Specific Keybindings

### Avante Diff Navigation (when AI shows suggestions)
```bash
]]              Jump to next AI suggestion
[[              Jump to previous AI suggestion
co              Accept "ours" (keep your code)
ct              Accept "theirs" (use AI suggestion)  
ca              Accept all AI suggestions
cb              Accept both versions (merge)
cc              Accept at cursor position
]x              Next diff conflict
[x              Previous diff conflict
```

### Avante Suggestion Controls
```bash
<M-l>           Accept AI suggestion
<M-]>           Next suggestion option
<M-[>           Previous suggestion option
<C-]>           Dismiss suggestion
```

### CodeCompanion Chat Controls
```bash
<C-s>           Send message (insert mode)
<CR>            Send message (normal mode)
<C-c>           Close chat
q               Quit chat (normal mode)
```

## ⚡ Quick Reference for Daily Workflows

### Speed File Navigation
```bash
<Space>ff       → type filename → <CR>     # < 3 seconds
<Space>e        → navigate → <CR>          # Browse structure
gd              → examine → <C-o>          # Follow definitions
<Space>fg       → search term             # Find across files
```

### AI Assistance Patterns
```bash
# Quick questions:
<Space>aa       → ask → review             # Avante inline help

# Deep discussions:  
<Space>cc       → start conversation       # CodeCompanion chat

# Provider choice:
<Space>pp       → choose AI → ask          # Parrot multi-AI
```

### Code Navigation Combos
```bash
<Space>ff       → find main file
gd              → go to definition
gr              → find all references
<Space>e        → explore in tree context
<Space>aa       → ask AI about code
```

### File Management Flow
```bash
<Space>e        → open tree
a               → create new file
<CR>            → open for editing
<Space>e        → close tree
<Space>w        → save
```

## 🎯 Context-Specific Quick Actions

### When You See an Error
```bash
]d              → jump to error
<Space>d        → see details
<Space>ca       → check quick fixes
gd              → understand the symbol
<Space>aa       → ask AI for help
```

### When Exploring New Code  
```bash
<Space>ff       → find entry point
K               → hover for info
gd              → go deeper
gr              → see usage
<Space>cc       → discuss with AI
```

### When Implementing Features
```bash
<Space>e        → create file structure  
<Space>fg       → search similar patterns
<Space>ae       → generate with AI
<Space>lf       → format code
<Space>aa       → review with AI
```

### When Debugging Issues
```bash
<Space>fg       → search error message
gd/gr           → trace code flow
<Space>d        → check diagnostics  
<Space>ca       → look for fixes
<Space>cc       → troubleshoot with AI
```

## 🔧 Emergency Commands

### If Things Go Wrong
```bash
:q!             Force quit without saving
u               Undo last change
<C-r>           Redo
<Esc>           Get back to normal mode
:w              Save immediately
:LspRestart     Restart language server
:checkhealth    Check Neovim health
```

### Buffer Recovery
```bash
:ls             List all buffers
:bd!            Force delete current buffer
:bufdo bd       Close all buffers
:e!             Reload file from disk
```

### Plugin Issues
```bash
:Lazy           Open plugin manager
:Mason          Manage language servers
:LspInfo        Check LSP status
:messages       See error messages
```

## 🎓 Learning Path Recommendations

### Week 1: Foundation
- [ ] Master hjkl movement (disable arrow keys!)
- [ ] Learn basic text objects (iw, i", i()
- [ ] Use <Space>ff and <Space>e daily
- [ ] Try <Space>aa for simple questions

### Week 2: Navigation  
- [ ] Master gd, gr, K for code exploration
- [ ] Learn buffer switching (<S-h>, <S-l>)
- [ ] Use <Space>fg for content search
- [ ] Start using <Space>cc for conversations

### Week 3: Efficiency
- [ ] Combine motions with operations (dw, ci", da()
- [ ] Use visual mode effectively
- [ ] Master window splits and navigation
- [ ] Choose AI providers strategically (<Space>pp)

### Week 4: Advanced
- [ ] Use macros (qa...q, @a)
- [ ] Master the dot command (.)
- [ ] Develop personal workflow patterns
- [ ] Optimize AI usage for different tasks

## 🚀 Pro Tips for Maximum Efficiency

### 1. Build Muscle Memory
- **Practice daily**: Spend 5 minutes each morning on vim motions
- **Force good habits**: Disable arrow keys, use hjkl only
- **Use text objects**: Think "change inner word" not "delete delete delete"

### 2. Leverage AI Strategically
- **Avante for quick help**: Immediate answers and code fixes
- **CodeCompanion for planning**: Architecture and complex discussions  
- **Parrot for choice**: Right AI model for the task

### 3. Master the Tools
- **Telescope for speed**: Fuzzy finding is faster than browsing
- **Neo-tree for context**: Visual structure understanding
- **LSP for intelligence**: Let the language server guide you

### 4. Develop Workflows
- **Investigation**: Find → Navigate → Understand → Ask AI
- **Implementation**: Plan with AI → Structure → Code → Review
- **Debugging**: Trace → Search → Fix → Validate

Remember: **Speed comes from patterns, not individual key presses**. Focus on developing smooth workflows that combine vim efficiency with AI intelligence! 🎯⚡

---

## 📱 Quick Reference Card (Print This!)

```
MOVEMENT         OPERATIONS        AI ASSISTANCE
h j k l          d c y p          <Space>aa  Ask Avante
w b e           u <C-r>          <Space>cc  CodeCompanion Chat  
0 ^ $           . ,              <Space>pp  Parrot Multi-AI
gg G            

TEXT OBJECTS     FILE NAV         CODE NAV
iw aw           <Space>ff        gd gr gi gD
i" a"           <Space>fg        K (hover)
i( a( i) a)     <Space>e         <Space>rn
i{ a{ i} a}     <Space>o         <Space>ca

BUFFERS          WINDOWS          LSP
<S-h> <S-l>     <C-h> <C-j>      [d ]d
<Space>bd       <C-k> <C-l>      <Space>d
<Space>fb       <C-Up/Down>      <Space>lf
```

Your AI-powered Neovim setup is ready to make you unstoppable! 🚀✨

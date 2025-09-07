# Neovim Basics & Vim Motions - Complete Guide

## 🎯 Essential Vim Philosophy

Vim follows a **language-based approach**: `[operator][motion]` or `[operator][text object]`

- **Operators**: What to do (`d`elete, `c`hange, `y`ank)
- **Motions**: Where to move (`w`ord, `l`ine, `p`aragraph)
- **Text Objects**: What to select (`i`nner, `a`round)

## 🚀 Getting Started

### Modes in Neovim
- **Normal Mode** (`Esc`) - Navigation and commands
- **Insert Mode** (`i`, `I`, `a`, `A`) - Text editing
- **Visual Mode** (`v`, `V`, `<C-v>`) - Text selection
- **Command Mode** (`:`) - Ex commands

### Essential Mode Switching
```
Normal → Insert:  i (before cursor), a (after cursor)
                  I (start of line), A (end of line)
                  o (new line below), O (new line above)

Any Mode → Normal: <Esc> or <C-c>
Normal → Command:  :
Normal → Search:   / (forward), ? (backward)
```

## 🎮 Core Navigation (Normal Mode)

### Basic Movement
```
Character:  h (left), j (down), k (up), l (right)
Word:       w (next word), b (back word), e (end word)
Line:       0 (line start), ^ (first non-blank), $ (line end)
Screen:     H (top), M (middle), L (bottom)
File:       gg (file start), G (file end), {line}G (go to line)
```

### Advanced Movement
```
Paragraph:  { (previous), } (next)
Sentence:   ( (previous), ) (next)
Matching:   % (matching bracket/paren)
Find:       f{char} (find forward), F{char} (find backward)
            t{char} (till forward), T{char} (till backward)
            ; (repeat find), , (reverse find)
Search:     /{pattern} (search forward), ?{pattern} (search backward)
            n (next match), N (previous match)
```

### Screen Navigation
```
Scroll:     <C-u> (half page up), <C-d> (half page down)
            <C-b> (full page up), <C-f> (full page down)
            zz (center line), zt (top), zb (bottom)
Jump:       <C-o> (jump back), <C-i> (jump forward)
```

## ⚡ Essential Operators

### Text Manipulation
```
Delete:     d{motion} (delete motion), dd (delete line)
            x (delete char), X (delete char before)
Change:     c{motion} (change motion), cc (change line)
            s (substitute char), S (substitute line)
Yank:       y{motion} (copy motion), yy (copy line)
Put:        p (paste after), P (paste before)
```

### Powerful Combinations
```
Word ops:   dw (delete word), cw (change word), yw (yank word)
Line ops:   dd (delete line), cc (change line), yy (yank line)
To end:     d$ or D (delete to end), c$ or C (change to end)
Inner:      diw (delete inner word), ciw (change inner word)
Around:     daw (delete around word), caw (change around word)
```

## 🎯 Text Objects (The Power of Vim)

### Inner vs Around
- **Inner (`i`)**: Contents only (excluding delimiters)
- **Around (`a`)**: Contents + delimiters

### Text Object Types
```
Words:      iw (inner word), aw (around word)
Sentences:  is (inner sentence), as (around sentence)
Paragraphs: ip (inner paragraph), ap (around paragraph)
Quotes:     i" (inner quotes), a" (around quotes)
            i' (inner single), a' (around single)
Brackets:   i( i) ib (inner parens), a( a) ab (around parens)
            i[ i] (inner square), a[ a] (around square)
            i{ i} iB (inner braces), a{ a} aB (around braces)
Tags:       it (inner tag), at (around tag)
```

### Practical Examples
```
ci"         Change inner quotes: "hello" → cursor inside
ca"         Change around quotes: "hello" → select quotes too
di(         Delete inner parentheses: (code) → delete code only
da(         Delete around parentheses: (code) → delete everything
ciw         Change inner word: hello → replace entire word
caw         Change around word: hello world → includes space
```

## 🔍 Search & Replace

### Basic Search
```
/{pattern}  Search forward
?{pattern}  Search backward
n           Next match
N           Previous match
*           Search word under cursor (forward)
#           Search word under cursor (backward)
```

### Search & Replace
```
:s/old/new/         Replace first occurrence in line
:s/old/new/g        Replace all in line
:%s/old/new/g       Replace all in file
:%s/old/new/gc      Replace all with confirmation
:s/<old>/new/g    Use regex (word boundaries)
```

## 💾 File Operations

### Basic File Commands
```
:w              Save file
:w filename     Save as filename
:wq or :x       Save and quit
:q              Quit (fails if unsaved)
:q!             Force quit (discard changes)
:e filename     Edit/open file
:e!             Reload current file
```

### Buffer Management
```
:ls             List buffers
:b{number}      Switch to buffer number
:bn             Next buffer
:bp             Previous buffer
:bd             Delete buffer
```

## 🎨 Visual Mode Power

### Visual Selection Types
```
v               Character-wise visual
V               Line-wise visual
<C-v>           Block-wise visual (column mode)
gv              Re-select last visual selection
```

### Visual Mode Operations
```
After selecting:
d               Delete selection
c               Change selection
y               Yank selection
>               Indent right
<               Indent left
=               Auto-format
u               Lowercase
U               Uppercase
```

## ⚙️ Your Custom Keymaps

### Leader Key Mappings (Space = Leader)
```
<Space>w        Save file
<Space>q        Quit
<Space>Q        Force quit all

File Navigation:
<Space>ff       Find files (Telescope)
<Space>fg       Live grep search
<Space>fb       Find buffers
<Space>fr       Recent files
<Space>e        Toggle Neo-tree
<Space>o        Focus Neo-tree

AI Features:
<Space>aa       Avante Ask
<Space>ae       Avante Edit (visual)
<Space>ac       Avante Chat
<Space>cc       CodeCompanion Chat
<Space>ce       CodeCompanion Edit (visual)
<Space>pp       Parrot Chat
<Space>pr       Parrot Rewrite (visual)

LSP Features:
gd              Go to definition
gr              Go to references
K               Show hover info
<Space>rn       Rename symbol
<Space>ca       Code actions
<Space>lf       Format document
[d              Previous diagnostic
]d              Next diagnostic
```

### Window Management
```
<C-h>           Move to left window
<C-j>           Move to down window
<C-k>           Move to up window
<C-l>           Move to right window

<C-Up>          Resize window up
<C-Down>        Resize window down
<C-Left>        Resize window left
<C-Right>       Resize window right
```

### Buffer Navigation
```
<S-l>           Next buffer
<S-h>           Previous buffer
<Space>bd       Delete buffer
<Space>ba       Delete all buffers except current
```

## 🔥 Advanced Techniques

### Macros (Automation)
```
q{register}     Start recording macro to register
q               Stop recording
@{register}     Play macro from register
@@              Repeat last macro
{number}@{register}  Repeat macro n times
```

### Marks (Bookmarks)
```
m{letter}       Set mark at current position
'{letter}       Jump to mark (line)
`{letter}       Jump to mark (exact position)
'.              Jump to last change
''              Jump to last position
```

### Folding
```
za              Toggle fold
zc              Close fold
zo              Open fold
zR              Open all folds
zM              Close all folds
```

## 💡 Workflow Optimization Tips

### 1. Think in Text Objects
Instead of: `dllllll` (delete 6 characters)
Use: `dw` (delete word) or `diw` (delete inner word)

### 2. Use Counts
```
3w              Move 3 words forward
5dd             Delete 5 lines
2ci"            Change inner quotes twice
```

### 3. Combine Operations
```
c$              Change to end of line
y^              Yank from start to cursor
d}              Delete to end of paragraph
```

### 4. Master Search Patterns
```
/TODO           Find TODO comments
/<function>   Find exact word "function"
/\w+@         Find words ending with @
```

### 5. Use Dot Command (.)
The `.` command repeats your last change:
```
ciw             Change inner word
.               Repeat on next word
n.              Find next and repeat
```

## 🎓 Learning Path

### Week 1: Basics
- Master h,j,k,l movement
- Learn i,a,o for insert mode
- Practice w,b,e for word movement
- Use d,c,y with basic motions

### Week 2: Text Objects
- Master iw,aw (inner/around word)
- Learn quote operations: i",a"
- Practice bracket operations: i(,a(,i{,a{
- Use ci,di,yi with text objects

### Week 3: Advanced Movement
- Master f,F,t,T for character finding
- Learn /,?,n,N for searching
- Practice gg,G,{,} for large movements
- Use marks for position bookmarks

### Week 4: Efficiency
- Record and use macros
- Master visual mode operations
- Learn advanced search/replace
- Combine all techniques fluently

## 🚀 Pro Tips

1. **Use relative line numbers**: Jump with `{number}j/k`
2. **Master the dot command**: Most powerful repeater
3. **Think before moving**: Plan your motion
4. **Use text objects**: They're more precise than motions
5. **Practice daily**: Muscle memory is key
6. **Don't use arrow keys**: Force yourself to use hjkl
7. **Learn one new thing daily**: Gradual improvement
8. **Use plugins wisely**: Don't let them replace core skills

Remember: **Vim is a language, not just key combinations!** Once you understand the grammar, you can combine operators, motions, and text objects infinitely.

The goal is to **think in vim motions** - instead of moving character by character, think "delete inner word", "change to next bracket", "yank around quotes".

Your AI-powered setup makes you even more powerful - use vim motions to quickly navigate and select, then let AI help with the heavy lifting! 🎯

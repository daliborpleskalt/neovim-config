# AI-Powered Git Branch Comparison - Complete Usage Guide

## 🎯 What is AI-Powered Git Branch Comparison?

This system transforms your Neovim into a **powerful git analysis workstation** that combines **IntelliJ-style branch comparison** with **cutting-edge AI intelligence**. It provides visual diff interfaces, interactive change navigation, and AI-powered analysis that helps you make smarter decisions about code changes.

**Key capabilities:**
- **Visual branch comparison** with side-by-side diffs
- **AI-powered change analysis** and risk assessment  
- **Intelligent cherry-picking** with dependency detection
- **Smart conflict resolution** with AI guidance
- **Automated code reviews** before commits
- **Professional commit message generation**

## 🛠️ Installation & Setup

### Required Plugins

Add these plugins to your lazy.nvim configuration:

```lua
-- Add to your plugins directory
return {
  -- Core git integration
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    keys = {
      { '<leader>gs', '<cmd>Git<cr>', desc = 'Git status' },
      { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = 'Git diff split' },
    },
  },

  -- Advanced diff viewer with branch comparison
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles' },
    keys = {
      { '<leader>gdo', '<cmd>DiffviewOpen<cr>', desc = 'Open diffview' },
      { '<leader>gdc', '<cmd>DiffviewClose<cr>', desc = 'Close diffview' },
      { '<leader>gdh', '<cmd>DiffviewFileHistory<cr>', desc = 'File history' },
    },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = true,
      use_icons = true,
      file_panel = {
        listing_style = 'tree',
        win_config = { position = 'left', width = 35 },
      },
    },
  },

  -- Interactive git interface
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      integrations = { telescope = true, diffview = true },
    },
    keys = { { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Open Neogit' } },
  },

  -- Advanced git search
  {
    'aaronhallaert/advanced-git-search.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-fugitive',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('telescope').load_extension('advanced_git_search')
    end,
    keys = {
      { '<leader>gsf', '<cmd>AdvancedGitSearch<cr>', desc = 'Advanced git search' },
    },
  },

  -- Telescope git integration
  {
    'mrloop/telescope-git-branch.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('git_branch')
    end,
    keys = {
      { '<leader>gtb', '<cmd>Telescope git_branch<cr>', desc = 'Git branches' },
    },
  },

  -- Git signs for inline info
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        -- Navigation
        vim.keymap.set('n', ']h', gs.next_hunk, { buffer = buffer, desc = 'Next hunk' })
        vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = buffer, desc = 'Prev hunk' })
        -- Actions
        vim.keymap.set('n', '<leader>ghs', gs.stage_hunk, { buffer = buffer, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>ghr', gs.reset_hunk, { buffer = buffer, desc = 'Reset hunk' })
        vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { buffer = buffer, desc = 'Preview hunk' })
        -- AI hunk analysis
        vim.keymap.set('n', '<leader>gha', function()
          gs.preview_hunk()
          vim.defer_fn(function()
            vim.cmd('AvanteAsk Analyze this git hunk for code quality and potential issues')
          end, 500)
        end, { buffer = buffer, desc = 'AI analyze hunk' })
      end,
    },
  },
}
```

### AI Integration Functions

Create `lua/git-ai.lua` with these AI-powered functions:

```lua
local M = {}

-- Compare branches with AI analysis
function M.compare_branches_with_ai()
  local branches = vim.fn.systemlist('git branch -a --format="%(refname:short)"')

  vim.ui.select(branches, { prompt = 'Select first branch:' }, function(branch1)
    if not branch1 then return end
    vim.ui.select(branches, { prompt = 'Select second branch:' }, function(branch2)
      if not branch2 then return end

      -- Open diffview comparison
      vim.cmd('DiffviewOpen ' .. branch1 .. '..' .. branch2)

      -- Trigger AI analysis
      vim.defer_fn(function()
        M.analyze_branch_diff(branch1, branch2)
      end, 1000)
    end)
  end)
end

-- AI analysis of branch differences
function M.analyze_branch_diff(branch1, branch2)
  local diff_cmd = string.format('git diff %s..%s --stat', branch1, branch2)
  local diff_stat = vim.fn.system(diff_cmd)
  local detailed_diff = vim.fn.system(string.format('git diff %s..%s', branch1, branch2))

  local analysis_prompt = string.format([[
# Git Branch Analysis: %s → %s

## Summary:
%s

## Changes:
%s

Please analyze and provide:
1. **Change Summary**: What's different between branches
2. **Impact Analysis**: Risks and benefits
3. **Code Quality**: Areas needing attention
4. **Merge Strategy**: Best integration approach
5. **Testing Focus**: Critical areas to test
]], branch1, branch2, diff_stat, detailed_diff:sub(1, 8000))

  -- Choose AI based on complexity
  if #detailed_diff > 10000 then
    vim.cmd('CodeCompanionChat')
  else
    vim.cmd('AvanteAsk ' .. vim.fn.shellescape(analysis_prompt))
  end
end

-- AI code review for staged changes
function M.ai_code_review_staged()
  local staged_diff = vim.fn.system('git diff --cached')
  if staged_diff == '' then
    vim.notify('No staged changes to review', vim.log.levels.WARN)
    return
  end

  local review_prompt = string.format([[
# Pre-Commit Code Review

## Staged Changes:
%s

Please review for:
1. **Code Quality**: Best practices and maintainability
2. **Bug Prevention**: Potential issues
3. **Performance**: Efficiency considerations
4. **Security**: Security implications
5. **Testing**: Coverage and strategy

Provide specific, actionable feedback.
]], staged_diff:sub(1, 10000))

  vim.cmd('AvanteAsk ' .. vim.fn.shellescape(review_prompt))
end

-- AI-powered cherry-pick assistant
function M.ai_cherry_pick_assistant()
  vim.ui.input({ prompt = 'Branch to cherry-pick from: ' }, function(branch)
    if not branch then return end

    local commits = vim.fn.systemlist(string.format('git log --oneline %s ^HEAD -10', branch))
    if #commits == 0 then
      vim.notify('No commits found', vim.log.levels.WARN)
      return
    end

    vim.ui.select(commits, { prompt = 'Select commit to analyze:' }, function(commit)
      if not commit then return end

      local commit_hash = commit:match('^(%S+)')
      local commit_diff = vim.fn.system('git show ' .. commit_hash)

      local analysis_prompt = string.format([[
# Cherry-Pick Analysis: %s

%s

Analyze for:
1. **Dependencies**: What this commit needs
2. **Conflict Risk**: Potential merge issues
3. **Compatibility**: Fit with current code
4. **Risk Assessment**: Safety level
5. **Recommendation**: Should this be applied?
]], commit, commit_diff:sub(1, 8000))

      vim.cmd('CodeCompanionChat')
      vim.defer_fn(function()
        vim.api.nvim_put({analysis_prompt}, 'l', true, true)
      end, 500)
    end)
  end)
end

-- Generate AI commit messages
function M.generate_ai_commit_message()
  local staged_diff = vim.fn.system('git diff --cached')
  if staged_diff == '' then
    vim.notify('No staged changes', vim.log.levels.WARN)
    return
  end

  local commit_prompt = string.format([[
Generate commit message for:

%s

Requirements:
- Conventional commits format
- Present tense
- Under 50 characters first line
- Include scope if applicable

Provide 3 options from best to least preferred.
]], staged_diff:sub(1, 5000))

  vim.cmd('AvanteAsk ' .. vim.fn.shellescape(commit_prompt))
end

-- Setup keybindings
function M.setup_keybindings()
  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', '<leader>gb', M.compare_branches_with_ai, 
    vim.tbl_extend('force', opts, { desc = '🔀 Compare branches with AI' }))
  vim.keymap.set('n', '<leader>gar', M.ai_code_review_staged, 
    vim.tbl_extend('force', opts, { desc = '🤖 AI review staged changes' }))
  vim.keymap.set('n', '<leader>gcp', M.ai_cherry_pick_assistant, 
    vim.tbl_extend('force', opts, { desc = '🍒 AI cherry-pick assistant' }))
  vim.keymap.set('n', '<leader>gcm', M.generate_ai_commit_message, 
    vim.tbl_extend('force', opts, { desc = '💬 Generate AI commit message' }))
end

M.setup_keybindings()
return M
```

## 🎯 Core Features & Usage

### 1. Visual Branch Comparison

#### Compare Any Two Branches
```vim
<leader>gb          " Interactive branch selection with AI analysis
<leader>gdo         " Open diffview for detailed comparison  
<leader>gdc         " Close diffview
```

**Example workflow:**
1. Press `<Space>gb`
2. Select first branch: `main`
3. Select second branch: `feature/auth`
4. AI automatically analyzes differences
5. Navigate changes with diffview interface

#### Compare Branch with Current Work
```vim
<leader>gc          " Compare branch with working directory
<leader>gdh         " Show file history in diffview
```

### 2. AI-Powered Analysis

#### Pre-Commit Code Review
```vim
<leader>gar         " AI review of all staged changes
<leader>gha         " AI analyze current git hunk
```

**AI provides:**
- Code quality assessment
- Potential bug detection
- Performance considerations
- Security implications
- Testing recommendations

#### Smart Cherry-Picking
```vim
<leader>gcp         " AI-assisted cherry-pick selection
```

**AI analyzes:**
- Commit dependencies
- Conflict probability
- Compatibility assessment
- Risk evaluation
- Application recommendations

#### Automated Commit Messages
```vim
<leader>gcm         " Generate AI commit messages
```

**Features:**
- Conventional commits format
- Proper scope detection
- Multiple options provided
- Professional tone

### 3. Advanced Git Operations

#### Git Search & History
```vim
<leader>gsf         " Advanced git search across history
<leader>gsc         " Search commits for specific file
<leader>gsb         " Search branch differences
```

#### Telescope Integration
```vim
<leader>gtb         " Fuzzy find git branches
<leader>gtc         " Browse git commits
<leader>gts         " Git status with Telescope
```

#### Interactive Git Interface
```vim
<leader>gg          " Open Neogit for interactive operations
```

## 🔧 Your Complete Keybinding Reference

### Branch Comparison & Analysis
```vim
<leader>gb          " 🔀 Compare branches with AI analysis
<leader>gc          " 📊 Compare branch with current working directory
<leader>gdo         " 👁️  Open diffview for detailed comparison
<leader>gdc         " ❌ Close diffview
<leader>gdh         " 📚 File history in diffview
```

### AI-Powered Operations  
```vim
<leader>gar         " 🤖 AI review of staged changes
<leader>gcp         " 🍒 AI cherry-pick assistant
<leader>gcm         " 💬 Generate AI commit messages
<leader>gha         " 🔍 AI analyze current git hunk
```

### File-Level Git Operations
```vim
<leader>ghs         " ⬆️  Stage current hunk
<leader>ghr         " ↩️  Reset current hunk  
<leader>ghp         " 👁️  Preview current hunk
]h                  " ➡️  Next git hunk
[h                  " ⬅️  Previous git hunk
```

### Search & History
```vim
<leader>gsf         " 🔍 Advanced git search
<leader>gsc         " 📋 Search file commit history
<leader>gsb         " 🌿 Search branch differences
```

### Telescope Git Integration
```vim
<leader>gtb         " 🔍 Telescope git branches
<leader>gtc         " 📋 Telescope git commits
<leader>gts         " 📊 Telescope git status
```

### Interactive Git Interface
```vim
<leader>gg          " 🎛️  Open Neogit interactive interface
<leader>gs          " 📊 Git status (Fugitive)
<leader>gd          " 📋 Git diff split
```

## 🎨 Master Workflow Patterns

### 1. The Feature Review Pattern

**Use when:** Reviewing feature branches before merging

```bash
# Step 1: Get the big picture
<Space>gb                    # Compare feature branch with main
# AI analyzes: "Adds user authentication. Medium risk - review middleware"

# Step 2: Dive into details  
# Navigate files in diffview interface
# Use file panel to see all changed files

# Step 3: Stage and review selectively
<Space>ghs                   # Stage good hunks
<Space>gha                   # AI analyze questionable hunks

# Step 4: Final review and commit
<Space>gar                   # AI review all staged changes
<Space>gcm                   # Generate professional commit message
```

**Example scenario:** "Reviewing user authentication feature"
```bash
1. <Space>gb → "main" → "feature/user-auth"
2. AI: "Adds JWT tokens, Redis sessions. Check error handling in middleware"
3. Navigate through auth.controller.ts, middleware.ts, user.model.ts
4. Stage approved changes, get AI feedback on concerns
5. Commit with AI-generated message: "feat(auth): implement JWT authentication"
```

### 2. The Selective Integration Pattern

**Use when:** Cherry-picking specific fixes from other branches

```bash
# Step 1: Find the right commits
<Space>gcp                   # Select source branch
# Choose from list of commits

# Step 2: AI analysis
# AI analyzes: "Security fix - safe to apply, needs dependency abc123"

# Step 3: Apply strategically
# Apply commits in recommended order
# Resolve conflicts with AI guidance

# Step 4: Validate integration
<Space>gar                   # Final AI review
```

**Example scenario:** "Applying security hotfix to current feature"
```bash
1. <Space>gcp → "hotfix/security-patch"
2. AI analyzes commit abc123: "Fixes SQL injection, requires validator update"
3. Apply validator dependency first, then security fix
4. AI validates: "Changes integrated safely, no conflicts"
```

### 3. The Daily Development Pattern

**Use when:** Regular development workflow with AI assistance

```bash
# Step 1: Check current status
<Space>gc                    # Compare current work with main
# See what's changed since last sync

# Step 2: Review and stage incrementally
<Space>gha                   # AI analyze each hunk before staging
<Space>ghs                   # Stage approved hunks

# Step 3: Commit with confidence
<Space>gar                   # AI review staged changes
<Space>gcm                   # Generate commit message
# Commit and push
```

**Example scenario:** "End of day commit routine"
```bash
1. <Space>gc → see 3 files changed since main
2. Review user.service.ts changes with <Space>gha
3. AI: "Good error handling, stage this hunk"
4. <Space>gar → AI: "Clean implementation, ready to commit"
5. <Space>gcm → "refactor(user): improve error handling in service layer"
```

### 4. The Conflict Resolution Pattern

**Use when:** Resolving merge conflicts with AI guidance

```bash
# Step 1: Open conflict resolution
<Space>gdo                   # Open diffview for merge conflicts
# See conflicts in visual interface

# Step 2: Get AI guidance
<Space>gha                   # AI analyze each conflict
# AI: "Keep both changes - they're compatible"

# Step 3: Resolve systematically
# Use diffview conflict resolution commands
<leader>co, <leader>ct, <leader>cb

# Step 4: Validate resolution
<Space>gar                   # AI review final resolution
```

## 🤖 AI Integration Strategies

### 1. Multi-Provider Usage

**For Large Changes (>10K lines):**
- Use **CodeCompanion** for deep architectural analysis
- Get comprehensive impact assessment
- Discuss complex merging strategies

**For Quick Reviews (<1K lines):**
- Use **Avante** for rapid code quality checks
- Get immediate feedback on hunks
- Quick commit message generation

**For Strategic Analysis:**
- Use **Parrot** to choose optimal AI provider
- Claude for security analysis
- GPT-4 for UI/UX related changes
- Perplexity for best practices research

### 2. Context-Aware Prompting

**Provide Rich Context:**
```vim
# Instead of: "Review this code"
# Use: "Review this authentication middleware for security issues and performance"

# Instead of: "Analyze this diff"  
# Use: "Analyze this feature branch diff for merge readiness and breaking changes"
```

**Include Historical Context:**
- Mention recent changes in related files
- Reference previous decisions or patterns
- Explain the business context or requirements

### 3. Progressive AI Analysis

**Level 1: Quick Hunk Analysis**
```vim
<Space>gha                   # Quick AI feedback on current hunk
```

**Level 2: Staged Changes Review**
```vim
<Space>gar                   # Comprehensive review of all staged changes
```

**Level 3: Branch Strategy Discussion**
```vim
<Space>gb                    # Full branch comparison with strategic analysis
```

## 🔧 Advanced Techniques

### 1. Custom AI Analysis Functions

You can extend the AI capabilities by creating custom analysis functions:

```lua
-- Custom security analysis
function M.ai_security_review()
  local diff = vim.fn.system('git diff --cached')
  local security_prompt = string.format([[
Focus on security analysis of these changes:
%s

Look for:
- SQL injection vulnerabilities  
- XSS prevention
- Authentication bypasses
- Data exposure risks
- Input validation issues

Provide specific security recommendations.
]], diff)

  vim.cmd('ParrotChatNew claude')  -- Use Claude for security analysis
end
```

### 2. Integration with External Tools

**Git Hooks Integration:**
```bash
# Pre-commit hook with AI review
#!/bin/sh
nvim --headless -c "lua require('git-ai').ai_code_review_staged()" -c "qa"
```

**CI/CD Integration:**
- Export AI analysis to CI pipeline
- Use AI recommendations for automated testing focus
- Generate release notes with AI assistance

### 3. Historical Pattern Analysis

**Analyze Code Evolution:**
```vim
<Space>gsf                   # Search for patterns across git history
# Find similar changes in the past
# Learn from previous implementations
```

**Track Technical Debt:**
- Use AI to identify accumulating technical debt
- Get recommendations for refactoring priorities
- Understand the impact of shortcuts taken

## 🚨 Troubleshooting

### Common Issues and Solutions

#### Diffview Not Opening
```bash
# Check git repository status
:Git status

# Ensure you're in a git repository
:pwd

# Try explicit branch comparison
:DiffviewOpen main..feature-branch
```

#### AI Analysis Not Working
```bash
# Check AI tool availability
:AvanteCheck
:CodeCompanionCheck

# Verify API keys are set
:echo $ANTHROPIC_API_KEY
:echo $OPENAI_API_KEY
```

#### Large Diff Performance Issues
```bash
# Limit diff size for AI analysis
git diff --stat main..feature  # Check size first
git diff main..feature -- specific-file.js  # Analyze specific files
```

#### Git Commands Failing
```bash
# Check git configuration
git config --list

# Verify remote repositories
git remote -v

# Update git if needed
git --version
```

### Performance Optimization

**For Large Repositories:**
- Use file-specific diff analysis
- Limit AI analysis to staged changes
- Use `git diff --name-only` for file lists first

**For Complex Branches:**
- Analyze commits individually with cherry-pick assistant
- Use incremental staging with hunk analysis
- Break large merges into smaller chunks

## 💡 Pro Tips & Advanced Usage

### 1. Efficiency Techniques

**Speed Up Branch Comparison:**
```vim
# Create aliases for common comparisons
:command! CompareMain lua require('git-ai').compare_with_main()
:command! ReviewStaged lua require('git-ai').ai_code_review_staged()
```

**Batch Operations:**
```vim
# Stage all AI-approved hunks in a file
]h<Space>gha<Space>ghs]h<Space>gha<Space>ghs  # Navigate, analyze, stage
```

### 2. Team Collaboration

**Standardize AI Prompts:**
- Create team-specific analysis templates
- Share common AI review patterns
- Establish commit message standards

**Code Review Process:**
1. Use AI pre-review before human review
2. Include AI analysis in pull request descriptions
3. Use AI-generated test focus areas

### 3. Integration with Your Workflow

**Morning Routine:**
```vim
<Space>gc                    # Check overnight changes
<Space>gtb                   # Switch to feature branch
<Space>gar                   # Review yesterday's work
```

**Before Push Routine:**
```vim
<Space>gar                   # Final AI review
<Space>gcm                   # Perfect commit message
git push origin feature-branch
```

**Code Review Prep:**
```vim
<Space>gb                    # Compare with main
# Include AI analysis in PR description
# Highlight AI-identified concerns
```

### 4. Customization Options

**Adjust AI Behavior:**
```lua
-- More detailed analysis
M.detailed_analysis = true

-- Security-focused reviews  
M.security_focus = true

-- Performance optimization hints
M.performance_hints = true
```

**Custom Keybindings:**
```lua
-- Add your preferred shortcuts
vim.keymap.set('n', '<leader>gai', M.comprehensive_ai_analysis)
vim.keymap.set('n', '<leader>gaq', M.quick_ai_review)
```

## 🎯 Success Indicators

### Beginner Level
- [ ] Can compare branches visually with `<Space>gb`
- [ ] Uses AI hunk analysis regularly with `<Space>gha`
- [ ] Stages changes selectively with guidance
- [ ] Generates commit messages with AI help

### Intermediate Level
- [ ] Combines multiple tools fluidly (diffview + AI + staging)
- [ ] Uses cherry-pick assistant effectively
- [ ] Resolves conflicts with AI guidance
- [ ] Adapts AI prompts for specific needs

### Advanced Level
- [ ] Creates custom AI analysis workflows
- [ ] Integrates with team processes seamlessly
- [ ] Uses multi-provider AI strategically
- [ ] Mentors others in AI-powered git workflows

### Expert Level
- [ ] Contributes improvements to the system
- [ ] Develops team-specific AI templates
- [ ] Optimizes workflows for specific project types
- [ ] Leads adoption of AI-powered development practices

## 🚀 Your AI-Powered Git Mastery Journey

This system transforms git from a simple version control tool into an **intelligent development assistant**. You now have:

- **🧠 Smart Analysis**: AI understands your code changes
- **🎯 Strategic Guidance**: Make better merge and integration decisions
- **⚡ Efficient Workflows**: Faster, more confident git operations
- **🛡️ Risk Mitigation**: Catch issues before they become problems
- **📈 Continuous Learning**: AI adapts to your codebase patterns

**Remember:** The goal isn't just to use AI, but to develop **better judgment** and **deeper understanding** of your code through intelligent assistance. Use AI as your pair programming partner for git operations! 🎯⚡

Your git workflow just became incredibly intelligent. Happy coding with your AI-powered git superpowers! 🚀✨

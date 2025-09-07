# Avante.nvim - Complete Usage Guide

## 🤖 What is Avante?

Avante.nvim brings **Cursor-like AI assistance** directly into Neovim. It provides:
- **Inline AI editing** - AI suggestions appear directly in your code
- **Smart refactoring** - AI-powered code improvements  
- **Contextual help** - AI understands your entire codebase
- **Multiple providers** - Claude, GPT-4, and Perplexity support

## 🚀 Your Avante Keymaps

### Primary Commands
```bash
<Space>aa       Avante Ask - Get AI help with current context
<Space>ae       Avante Edit - AI edit selected code (visual mode)
<Space>ac       Avante Chat - Open AI chat sidebar
<Space>at       Avante Toggle - Toggle Avante interface
```

### Navigation in Avante
```bash
]]              Jump to next AI suggestion
[[              Jump to previous AI suggestion

# In diff mode:
co              Accept "ours" (keep your code)
ct              Accept "theirs" (use AI suggestion)
ca              Accept "all theirs" (use all AI suggestions)
cb              Accept "both" (merge both versions)
cc              Accept at cursor position
]x              Next diff conflict
[x              Previous diff conflict
```

### Suggestion Controls
```bash
<M-l>           Accept AI suggestion
<M-]>           Next suggestion option
<M-[>           Previous suggestion option  
<C-]>           Dismiss suggestion
```

## 💡 How to Use Avante Effectively

### 1. Ask for Help (`<Space>aa`)

**Best for**: Getting explanations, debugging help, code reviews

**How to use**:
1. Position cursor in relevant code
2. Press `<Space>aa`
3. Type your question in the prompt
4. AI analyzes context and provides help

**Example workflow**:
```typescript
// You have this function and want help
function calculateTotal(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// 1. Place cursor in function
// 2. Press <Space>aa
// 3. Ask: "How can I make this more robust?"
// 4. AI suggests error handling, type validation, etc.
```

**Great questions to ask**:
- "How can I optimize this function?"
- "What are potential bugs in this code?"
- "How do I handle errors here?"
- "Can you explain what this code does?"
- "What's the best practice for this pattern?"

### 2. Edit Code (`<Space>ae`)

**Best for**: Refactoring, improvements, transformations

**How to use**:
1. Select code in visual mode (`v`, `V`, or `<C-v>`)
2. Press `<Space>ae`
3. Describe what you want changed
4. Review and accept/reject AI suggestions

**Example workflow**:
```typescript
// Select this code block
const users = await fetch('/api/users')
  .then(res => res.json())
  .then(data => data.users);

// 1. Select the code (visual mode)
// 2. Press <Space>ae  
// 3. Say: "Add error handling and TypeScript types"
// 4. AI transforms it to:

interface User {
  id: number;
  name: string;
  email: string;
}

interface ApiResponse {
  users: User[];
  error?: string;
}

try {
  const response = await fetch('/api/users');
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  const data: ApiResponse = await response.json();
  if (data.error) {
    throw new Error(data.error);
  }
  const users: User[] = data.users;
} catch (error) {
  console.error('Failed to fetch users:', error);
  // Handle error appropriately
}
```

**Great edit requests**:
- "Add TypeScript types"
- "Add error handling"  
- "Optimize for performance"
- "Make this more readable"
- "Convert to async/await"
- "Add JSDoc comments"
- "Refactor using modern syntax"

### 3. Chat Mode (`<Space>ac`)

**Best for**: Long conversations, brainstorming, complex problems

**How to use**:
1. Press `<Space>ac` to open chat sidebar
2. Have ongoing conversation about your code
3. Ask follow-up questions
4. Get iterative improvements

**Example conversation**:
```
You: I need to build a user authentication system

AI: I'll help you build a secure authentication system. What 
    technology stack are you using?

You: Node.js with TypeScript, Express, and PostgreSQL

AI: Great! Here's a comprehensive approach:
    1. Password hashing with bcrypt
    2. JWT tokens for sessions
    3. Input validation with Joi
    4. Rate limiting for security

    Would you like me to start with the user model?

You: Yes, show me the User model with TypeScript

AI: [Provides detailed User interface and database model]
```

### 4. Toggle Interface (`<Space>at`)

**Best for**: Showing/hiding Avante panels

Quick way to toggle the Avante interface on/off without losing context.

## 🎯 Avante Workflow Patterns

### Pattern 1: Code Review & Improvement
```bash
1. Open file with questionable code
2. <Space>aa - Ask "Review this code for issues"
3. Select problematic sections  
4. <Space>ae - Request specific improvements
5. Accept/reject suggestions with co/ct
```

### Pattern 2: Feature Development
```bash
1. <Space>ac - Start chat about feature requirements
2. Discuss architecture and approach
3. Select code sections to implement
4. <Space>ae - Generate implementation
5. <Space>aa - Ask for testing strategies
```

### Pattern 3: Debugging & Troubleshooting  
```bash
1. Position cursor at error/bug
2. <Space>aa - Explain the issue
3. Get debugging suggestions
4. Select problematic code
5. <Space>ae - Request fixes
```

### Pattern 4: Learning & Documentation
```bash
1. Select unfamiliar code
2. <Space>aa - Ask "Explain this code"
3. Follow up with "Show me similar patterns"
4. Request documentation: <Space>ae "Add comments"
```

## 🛠️ Working with AI Suggestions

### Accepting/Rejecting Changes

When Avante shows code suggestions, you'll see **diff highlights**:
- **Green (incoming)**: AI suggested changes
- **Red (current)**: Your existing code

**Decision commands**:
```bash
co              Keep your version ("ours")
ct              Use AI version ("theirs")  
ca              Accept all AI suggestions
cb              Merge both versions (where possible)
cc              Accept at cursor position
```

### Navigation in Diffs
```bash
]x              Jump to next conflict
[x              Jump to previous conflict
]]              Next AI suggestion block
[[              Previous AI suggestion block
```

## 🎨 Advanced Avante Techniques

### 1. Context-Aware Requests

Avante understands your **entire file context**. Be specific about scope:

```bash
# Instead of: "Fix this"
# Say: "Fix the TypeScript errors in this React component"

# Instead of: "Make it better" 
# Say: "Optimize this database query for large datasets"
```

### 2. Multi-Step Workflows

Use Avante for complex, multi-step improvements:

```bash
Step 1: <Space>aa - "Analyze this function for performance issues"
Step 2: <Space>ae - "Add input validation" 
Step 3: <Space>ae - "Add comprehensive error handling"
Step 4: <Space>aa - "Suggest unit tests for this function"
```

### 3. Language-Specific Requests

Tailor requests to your programming language:

**TypeScript**:
- "Add strict TypeScript types"
- "Convert to generic function"
- "Add proper interfaces"

**React**:
- "Convert to React hooks"
- "Add prop validation"
- "Optimize for re-renders"

**Rust**:
- "Add proper error handling with Result<>"
- "Make this more idiomatic Rust"
- "Add lifetime annotations"

## 🔧 Troubleshooting Common Issues

### Issue: "Cannot make changes, 'modifiable' is off"

**Solution**: Your configuration includes automatic fixes, but manually:
```vim
:set modifiable
:set noreadonly
```

Or use safe keymap: `<Space>fm` (Force Modifiable)

### Issue: AI suggestions not appearing

**Checklist**:
1. Check API key in `~/.env.nvim`
2. Verify internet connection
3. Check if file is writable
4. Try in a different buffer

### Issue: Poor AI responses

**Tips for better responses**:
1. **Be specific**: "Add error handling for network failures"
2. **Provide context**: "This is a React component for user profiles"
3. **Set expectations**: "Make it production-ready with TypeScript"
4. **Ask follow-ups**: Continue the conversation for refinement

### Issue: Diff conflicts hard to resolve

**Navigation help**:
1. Use `]x` and `[x` to jump between conflicts
2. Use `co` (ours) and `ct` (theirs) to resolve quickly
3. Use visual mode to select specific sections before accepting

## 🎯 Best Practices

### 1. Start Small
Begin with simple requests:
- "Add comments to this function"
- "Fix indentation" 
- "Add type annotations"

### 2. Be Conversational
Treat Avante like a pair programming partner:
- Ask questions: "What do you think about this approach?"
- Request alternatives: "Show me another way to do this"
- Seek explanations: "Why is this pattern better?"

### 3. Iterate and Refine
Don't expect perfect results immediately:
- Make initial request
- Review AI suggestion
- Ask for adjustments: "Make it more concise"
- Repeat until satisfied

### 4. Combine with Vim Motions
Use Vim efficiency with AI power:
```bash
# Select function with text object, then improve it
vaf         # Select around function
<Space>ae   # Edit with AI

# Select inner paragraph, then document it
vip         # Select inner paragraph  
<Space>ae   # Add documentation
```

### 5. Use Context Effectively
Help AI understand your codebase:
- Open related files in other buffers
- Include relevant imports/types in selection
- Mention frameworks/libraries you're using

## 🚀 Productivity Workflows

### Morning Code Review
```bash
1. Open yesterday's work
2. <Space>aa - "Review this code for issues"
3. Address suggestions one by one
4. Use <Space>ae for improvements
```

### Feature Development
```bash
1. <Space>ac - Discuss feature requirements
2. Plan implementation approach
3. Use <Space>ae for code generation
4. <Space>aa for testing strategies
```

### Learning New Patterns
```bash
1. Find example code online
2. Paste into Neovim
3. <Space>aa - "Explain this pattern"  
4. <Space>ae - "Adapt this for my use case"
```

### Refactoring Legacy Code
```bash
1. Select legacy function
2. <Space>aa - "What are the issues here?"
3. <Space>ae - "Modernize this code"
4. <Space>aa - "Add proper testing"
```

## 🎓 Pro Tips

1. **Keep conversations going**: Use `<Space>ac` for iterative improvement
2. **Be specific about style**: "Use functional programming style"
3. **Ask for explanations**: Always understand what AI suggests
4. **Combine with LSP**: Use `gd`, `gr` for context, then ask AI
5. **Save good prompts**: Note what works well for future use
6. **Use in different contexts**: Try AI help for configs, docs, tests
7. **Don't over-rely**: Use AI to learn, not replace thinking

Remember: **Avante is your AI pair programming partner**. The more context and specific guidance you provide, the better results you'll get! 🎯

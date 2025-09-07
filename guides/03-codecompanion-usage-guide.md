# CodeCompanion.nvim - Complete Usage Guide

## 💬 What is CodeCompanion?

CodeCompanion.nvim provides **conversational AI** directly in Neovim with:
- **Persistent chat sessions** - Long-form conversations with AI
- **Inline code assistance** - AI suggestions within your editor
- **Multiple AI providers** - Claude, GPT-4, and Perplexity support
- **Context-aware responses** - AI understands your project structure

## 🚀 Your CodeCompanion Keymaps

### Primary Commands
```bash
<Space>cc       CodeCompanion Chat - Open AI chat interface
<Space>ce       CodeCompanion Edit - AI edit selected code (visual mode)
<Space>cm       CodeCompanion Actions - Show available AI actions menu
```

### Chat Interface Navigation
```bash
# In chat buffer:
<C-s>           Send message (insert mode)
<CR>            Send message (normal mode)  
<C-c>           Close chat
q               Quit chat (normal mode)
```

## 💡 CodeCompanion vs Avante - When to Use Which?

### Use CodeCompanion (`<Space>cc`) for:
- **Long conversations** - Complex problem-solving discussions
- **Brainstorming** - Architecture decisions, approach planning  
- **Learning** - Deep explanations, concept exploration
- **Multiple iterations** - Back-and-forth refinement
- **Project-wide questions** - Architecture, patterns, best practices

### Use Avante (`<Space>aa`) for:
- **Quick questions** - Immediate answers about specific code
- **Inline editing** - Direct code improvements and refactoring
- **Code review** - Fast feedback on code quality
- **Specific fixes** - Targeted improvements to selected code

## 🎯 How to Use CodeCompanion Effectively

### 1. Start a Chat Session (`<Space>cc`)

**Perfect for**: Complex problems, architecture discussions, learning

**How to use**:
1. Press `<Space>cc` to open chat interface
2. Type your question or problem description
3. Press `<C-s>` (insert mode) or `<CR>` (normal mode) to send
4. Continue conversation with follow-up questions

**Example conversation**:
```
You: I'm building a TypeScript REST API with Express. What's the best 
     architecture for handling user authentication?

AI: For a TypeScript Express API, I recommend a layered architecture:

    1. **Controller Layer**: Handle HTTP requests/responses
    2. **Service Layer**: Business logic and authentication rules  
    3. **Repository Layer**: Database operations
    4. **Middleware Layer**: JWT validation, rate limiting

    Key components you'll need:
    - JWT token generation/validation
    - Password hashing (bcrypt)
    - User model with proper TypeScript types
    - Auth middleware for protected routes

    Would you like me to show you the implementation for any of these?

You: Yes, show me the auth middleware implementation

AI: Here's a robust auth middleware with TypeScript:

    ```typescript
    import jwt from 'jsonwebtoken';
    import { Request, Response, NextFunction } from 'express';

    interface AuthRequest extends Request {
      user?: {
        id: string;
        email: string;
        role: string;
      };
    }

    export const authenticateToken = (
      req: AuthRequest, 
      res: Response, 
      next: NextFunction
    ): void => {
      const authHeader = req.headers['authorization'];
      const token = authHeader && authHeader.split(' ')[1];

      if (!token) {
        res.status(401).json({ error: 'Access token required' });
        return;
      }

      try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET!) as any;
        req.user = decoded;
        next();
      } catch (error) {
        res.status(403).json({ error: 'Invalid or expired token' });
      }
    };
    ```

You: How do I handle token refresh?

AI: [Continues with token refresh implementation...]
```

### 2. Edit Code (`<Space>ce`)

**Perfect for**: Transforming selected code with AI assistance

**How to use**:
1. Select code in visual mode (`v`, `V`, or `<C-v>`)
2. Press `<Space>ce`
3. Describe the transformation you want
4. AI provides improved version

**Example workflow**:
```typescript
// Select this basic function
function getUser(id) {
  return fetch(`/api/users/${id}`)
    .then(res => res.json());
}

// 1. Select the function (visual mode)
// 2. Press <Space>ce
// 3. Say: "Make this production-ready with TypeScript, error handling, and proper types"

// AI transforms it to:
interface User {
  id: string;
  name: string;
  email: string;
  createdAt: string;
}

interface ApiError {
  message: string;
  code: string;
  status: number;
}

async function getUser(id: string): Promise<User> {
  try {
    const response = await fetch(`/api/users/${id}`);

    if (!response.ok) {
      const errorData: ApiError = await response.json();
      throw new Error(`API Error: ${errorData.message} (${response.status})`);
    }

    const user: User = await response.json();

    // Validate required fields
    if (!user.id || !user.email) {
      throw new Error('Invalid user data received from API');
    }

    return user;
  } catch (error) {
    console.error('Failed to fetch user:', error);
    throw error;
  }
}
```

### 3. AI Actions Menu (`<Space>cm`)

**Perfect for**: Discovering available AI capabilities

Shows a menu of available CodeCompanion actions:
- **Chat**: Start new conversation
- **Edit**: Transform selected code
- **Explain**: Get code explanations
- **Fix**: Identify and fix issues
- **Optimize**: Performance improvements
- **Test**: Generate test cases

## 🎨 Advanced CodeCompanion Workflows

### 1. Architecture Planning Session

```bash
# Start architectural discussion
<Space>cc

Conversation flow:
You: "I need to design a microservices architecture for an e-commerce platform. 
     Services needed: users, products, orders, payments, notifications"

AI: [Provides detailed architecture breakdown]

You: "How do I handle inter-service communication?"

AI: [Explains API Gateway, message queues, event-driven patterns]

You: "Show me the user service API design"

AI: [Provides REST API specification with TypeScript types]
```

### 2. Code Review and Improvement

```typescript
// Step 1: Select problematic code
const processOrder = (order) => {
  // Complex, untyped legacy code
  let total = 0;
  for (let i = 0; i < order.items.length; i++) {
    total += order.items[i].price * order.items[i].qty;
    if (order.items[i].discount) {
      total -= order.items[i].discount;
    }
  }
  return total;
};

// Step 2: Use CodeCompanion edit
<Space>ce "Review and improve this code with modern TypeScript"

// Step 3: AI provides improved version with types, validation, etc.
```

### 3. Learning New Technologies

```bash
<Space>cc

You: "I'm new to Rust. Can you explain ownership and borrowing with practical examples?"

AI: [Provides comprehensive explanation with code examples]

You: "Show me how to handle errors in Rust"

AI: [Explains Result<T, E> with examples]

You: "Convert this JavaScript function to idiomatic Rust"
[Paste JavaScript code]

AI: [Provides Rust equivalent with explanations]
```

### 4. Test-Driven Development

```bash
<Space>cc

You: "I want to write tests for a user authentication service. Guide me through TDD approach."

AI: [Explains TDD principles, suggests test structure]

You: "Write comprehensive tests for JWT token validation"

AI: [Provides detailed test suite with edge cases]

# Then select your implementation and refine:
<Space>ce "Make this pass all the suggested tests"
```

## 🛠️ Chat Interface Tips

### Effective Communication

**Be specific about context**:
```
❌ "How do I fix this?"
✅ "How do I fix this TypeScript compilation error in my React component?"

❌ "Make it better"  
✅ "Optimize this database query for handling 10k+ records"

❌ "Add tests"
✅ "Write Jest unit tests for this authentication middleware with edge cases"
```

**Provide relevant information**:
```
"I'm working on a Node.js Express API using:
- TypeScript
- PostgreSQL with Prisma ORM  
- JWT authentication
- Jest for testing

How should I structure my user registration endpoint?"
```

### Managing Long Conversations

**Keep context focused**:
- Reference previous parts: "Based on the auth middleware you showed earlier..."
- Summarize when needed: "So far we've covered authentication and authorization..."
- Ask for clarification: "Can you elaborate on the rate limiting part?"

**Save important information**:
- Copy code snippets to your files as you go
- Create notes for architectural decisions
- Save useful prompts for future use

## 🔧 Advanced Techniques

### 1. Multi-File Context

When working with multiple files, provide context:

```bash
<Space>cc

You: "I have these files in my project:
     - user.model.ts (User interface and validation)
     - auth.service.ts (authentication logic)  
     - user.controller.ts (HTTP endpoints)

     I need to add password reset functionality. How should I structure this across these files?"
```

### 2. Incremental Development

Use CodeCompanion for step-by-step feature building:

```bash
Session 1: Plan the feature architecture
Session 2: Implement core functionality  
Session 3: Add error handling and validation
Session 4: Write tests and documentation
Session 5: Optimize and refactor
```

### 3. Code Migration and Refactoring

```bash
<Space>cc

You: "I need to migrate this legacy jQuery code to modern React with TypeScript. 
     The code handles a complex form with validation and AJAX submission."

# Paste legacy code

AI: [Provides migration strategy and React implementation]

# Continue conversation for specific parts:
You: "How do I handle the validation part with React Hook Form?"
You: "Convert the AJAX calls to use React Query"
```

### 4. Performance Optimization

```bash
<Space>cc

You: "My React app is slow with large lists (1000+ items). Current implementation:"

# Share relevant code

AI: [Suggests virtualization, memoization, code splitting]

# Follow up with specific optimizations:
<Space>ce on selected components for React.memo implementation
<Space>ce on hooks for useMemo/useCallback optimization
```

## 🎯 Domain-Specific Workflows

### Frontend Development (React/TypeScript)
```bash
Topics to discuss:
- Component architecture and patterns
- State management strategies  
- Performance optimization techniques
- Testing approaches (unit, integration, e2e)
- Build optimization and bundling
```

### Backend Development (Node.js/Express)
```bash
Topics to discuss:
- API design and RESTful principles
- Database design and ORM usage
- Authentication and authorization patterns
- Error handling and logging strategies
- Scalability and performance considerations
```

### DevOps and Infrastructure
```bash
Topics to discuss:
- Docker containerization strategies
- CI/CD pipeline design
- Cloud deployment patterns
- Monitoring and logging setup
- Security best practices
```

### Database Design
```bash
Topics to discuss:
- Schema design and normalization
- Query optimization techniques
- Index strategies
- Migration patterns
- Data modeling for specific use cases
```

## 🚀 Productivity Patterns

### Daily Development Workflow

**Morning Planning**:
```bash
<Space>cc
"What should I focus on today for this feature? 
 Here's what I accomplished yesterday: [summary]
 Here are today's requirements: [requirements]"
```

**Stuck on Problems**:
```bash
<Space>cc  
"I'm having trouble with [specific issue].
 Here's what I've tried: [attempts]
 Here's the error I'm getting: [error]
 What should I try next?"
```

**Code Review Prep**:
```bash
<Space>cc
"Review this implementation before I submit for PR:
 [paste code]
 What issues should I address?"
```

**End-of-Day Reflection**:
```bash
<Space>cc
"What did I learn today? What should I study next to improve this code?"
```

### Learning New Technologies

**Structured Learning**:
```bash
Day 1: "Explain [technology] fundamentals with examples"
Day 2: "Show me common patterns and best practices"  
Day 3: "What are the gotchas and pitfalls to avoid?"
Day 4: "How does this integrate with [existing tech stack]?"
Day 5: "Give me a real-world project to practice"
```

### Problem-Solving Framework

**For Complex Issues**:
```bash
1. "Help me break down this problem: [description]"
2. "What are the possible approaches to solve this?"
3. "What are the trade-offs of each approach?"
4. "Which approach fits best for [specific context]?"
5. "Help me implement the chosen solution step by step"
```

## 🎓 Pro Tips

1. **Treat it like pair programming**: Ask questions, seek explanations
2. **Provide context liberally**: More context = better responses  
3. **Ask for alternatives**: "Show me another way to do this"
4. **Request explanations**: "Why is this approach better?"
5. **Build on previous responses**: Reference earlier parts of conversation
6. **Save good conversations**: Copy important insights to documentation
7. **Use for learning**: Don't just get solutions, understand principles
8. **Combine with other tools**: Use LSP for navigation, then discuss with AI

## 🔄 Integration with Your Workflow

### With Avante
- Use CodeCompanion for **planning and discussion**
- Use Avante for **implementation and quick fixes**

### With Neo-tree  
- Browse files in Neo-tree
- Open related files for context
- Discuss file structure with CodeCompanion

### With Telescope
- Find relevant code with Telescope
- Use CodeCompanion to understand and improve findings

### With LSP
- Use `gd`, `gr` for code navigation
- Discuss findings and improvements with CodeCompanion

Remember: **CodeCompanion is your AI mentor and pair programming partner**. Use it for deep technical discussions, learning, and solving complex problems that benefit from conversation and iteration! 🎯

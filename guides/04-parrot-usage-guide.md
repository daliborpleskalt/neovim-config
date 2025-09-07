# Parrot.nvim - Complete Usage Guide

## 🦜 What is Parrot?

Parrot.nvim is your **multi-provider AI assistant** that gives you:
- **Provider flexibility** - Switch between Claude, GPT-4, and Perplexity
- **Cost optimization** - Use different models for different tasks
- **Multiple AI contexts** - Chat, commands, and topic discussions
- **Smart model selection** - Right model for the right job

## 🚀 Your Parrot Keymaps

### Primary Commands
```bash
<Space>pp       Parrot Chat - Start new AI chat with provider selection
<Space>pr       Parrot Rewrite - AI rewrite selected code (visual mode)
```

### Provider Selection
When you use Parrot commands, you'll get a provider selection menu:
```
1. Claude (Anthropic) - Best for complex reasoning and code
2. GPT-4 (OpenAI) - Great for general tasks and creativity  
3. Perplexity - Cost-effective with web search capabilities
```

## 💡 Understanding Parrot's Multi-Provider Approach

### Claude (Anthropic) - The Reasoning Expert
**Best for**:
- Complex code analysis and refactoring
- Architecture decisions and design patterns
- Detailed explanations and debugging
- Production-ready code generation

**When to use**:
- Complex refactoring tasks
- System design discussions  
- Code review and optimization
- Learning complex concepts

### GPT-4 (OpenAI) - The Creative Generalist  
**Best for**:
- Creative problem solving
- Documentation and writing
- Brainstorming and ideation
- General programming help

**When to use**:
- Writing documentation
- Creative coding solutions
- Explaining concepts to others
- Quick prototyping

### Perplexity - The Research Assistant
**Best for**:
- Up-to-date information (web search)
- Cost-effective queries
- Quick answers and research
- Latest technology trends

**When to use**:
- Researching new libraries/frameworks
- Getting current best practices
- Cost-sensitive operations
- Quick factual questions

## 🎯 How to Use Parrot Effectively

### 1. Strategic Chat Sessions (`<Space>pp`)

**Provider Selection Strategy**:

**For Architecture & Complex Code → Choose Claude**:
```
You: I need to design a scalable microservices architecture for a social media platform

Claude: I'll help you design a robust microservices architecture. Let's break this down:

1. **Core Services**:
   - User Service (authentication, profiles)
   - Content Service (posts, media)  
   - Social Graph Service (followers, relationships)
   - Feed Service (timeline generation)
   - Notification Service (real-time alerts)

2. **Supporting Services**:
   - API Gateway (routing, rate limiting)
   - Media Processing Service (image/video)
   - Search Service (content discovery)
   - Analytics Service (metrics, insights)

3. **Data Strategy**:
   - User data: PostgreSQL (ACID compliance)
   - Social graph: Neo4j (relationship queries)
   - Feed data: Redis (fast access)
   - Media storage: S3 + CDN
   - Search: Elasticsearch

Would you like me to dive deeper into any specific service?
```

**For Creative Solutions → Choose GPT-4**:
```
You: I want to gamify my learning app. Give me creative ideas for engagement

GPT-4: Here are some creative gamification ideas for your learning app:

🎯 **Progress & Achievement System**:
- Learning streaks with visual fire effects
- Skill trees that unlock like RPG games
- "Knowledge kingdoms" you build as you learn
- Seasonal challenges with themed rewards

🏆 **Social Competition**:
- Study buddy duels with friendly wagering
- Team-based learning quests  
- Leaderboards with fun categories ("Night Owl Learner", "Weekend Warrior")
- Collaborative world-building where everyone contributes

🎮 **Interactive Elements**:
- "Boss battles" - challenging review sessions
- Loot boxes with study tools and themes
- Pet companions that grow with your progress
- Learning dungeons with mystery topics

Which direction interests you most?
```

**For Research & Current Info → Choose Perplexity**:
```
You: What are the latest trends in React development for 2025?

Perplexity: Based on current industry trends and recent developments:

🚀 **React 19 & Beyond**:
- Server Components becoming mainstream
- Built-in data fetching improvements
- Enhanced concurrent features
- Better TypeScript integration

⚡ **Performance Trends**:
- Partial Hydration techniques
- Island Architecture adoption
- Edge-side rendering patterns
- Micro-frontend architectures

🛠️ **Tooling Evolution**:
- Vite replacing Create React App
- Bun as JavaScript runtime
- Biome for linting/formatting
- Turbo for monorepo management

Would you like me to research specific tools or patterns?
```

### 2. Smart Code Rewriting (`<Space>pr`)

**Choose provider based on task complexity**:

**Complex Refactoring → Claude**:
```typescript
// Select this legacy code:
function processUserData(users) {
  let result = [];
  for (let i = 0; i < users.length; i++) {
    if (users[i].active && users[i].age >= 18) {
      result.push({
        id: users[i].id,
        name: users[i].firstName + ' ' + users[i].lastName,
        email: users[i].email,
        subscription: users[i].premium ? 'premium' : 'basic'
      });
    }
  }
  return result;
}

// <Space>pr → Choose Claude → "Make this production-ready TypeScript with proper types, error handling, and modern patterns"

// Claude provides comprehensive refactoring with types, validation, functional patterns
```

**Quick Improvements → GPT-4**:
```javascript
// Select simple code:
const colors = ['red', 'blue', 'green'];
colors.forEach((color) => {
  console.log(color);
});

// <Space>pr → Choose GPT-4 → "Make this more modern and functional"

// GPT-4 provides quick, clean improvements
```

**Research-Based Improvements → Perplexity**:
```python
# Select Python code:
def fetch_data(url):
    response = requests.get(url)
    return response.json()

# <Space>pr → Choose Perplexity → "Update this to use current Python best practices and latest libraries"

// Perplexity provides current best practices with latest library recommendations
```

## 🛠️ Advanced Parrot Workflows

### 1. Multi-Provider Problem Solving

**The Consultation Approach**:
```bash
Step 1: <Space>pp → Perplexity → Research current approaches
Step 2: <Space>pp → Claude → Deep technical analysis  
Step 3: <Space>pp → GPT-4 → Creative alternatives
Step 4: <Space>pp → Claude → Final implementation plan
```

**Example workflow**:
```
Problem: "Build a real-time collaboration feature like Google Docs"

Perplexity Session: Research current technologies (WebRTC, WebSockets, OT, CRDT)
Claude Session: Analyze technical complexity and architecture options
GPT-4 Session: Brainstorm UX patterns and creative features
Claude Session: Design final technical implementation
```

### 2. Cost-Optimized Development

**Use cheaper models for routine tasks**:
```bash
# Quick questions → Perplexity (cost-effective)
<Space>pp → Perplexity → "How do I center a div in CSS?"

# Complex problems → Claude (when you need the best)
<Space>pp → Claude → "Design a distributed caching strategy for microservices"

# Creative tasks → GPT-4 (balanced cost/creativity)
<Space>pp → GPT-4 → "Name my new productivity app and design the onboarding flow"
```

### 3. Specialized Use Cases

**Learning New Technologies**:
```bash
Day 1: Perplexity → "What's new in [technology] and current adoption?"
Day 2: GPT-4 → "Explain [technology] concepts with creative analogies"  
Day 3: Claude → "Show me production-ready [technology] patterns"
Day 4: Claude → "Review my [technology] implementation"
```

**Code Review Process**:
```bash
Round 1: GPT-4 → Quick readability and style feedback
Round 2: Claude → Deep architectural and performance analysis
Round 3: Perplexity → Check against current best practices
```

**Documentation Writing**:
```bash
Structure: Claude → "Outline comprehensive documentation for this API"
Content: GPT-4 → "Write engaging, clear documentation sections"
Examples: Claude → "Create realistic, production-ready code examples"
Review: Perplexity → "Check against current documentation standards"
```

## 🎨 Provider-Specific Prompt Strategies

### Claude Prompts (Detailed & Technical)
```
"Analyze this system architecture for scalability issues. Consider:
- Database query patterns and potential bottlenecks
- Caching strategies and cache invalidation
- API design and rate limiting approaches  
- Error handling and resilience patterns
- Monitoring and observability requirements"
```

### GPT-4 Prompts (Creative & Conversational)
```
"Help me explain microservices to a junior developer using analogies 
and real-world examples. Make it engaging and easy to understand."
```

### Perplexity Prompts (Research & Current)
```
"What are the current industry standards for API authentication in 2025? 
Include recent security recommendations and popular libraries."
```

## 🚀 Workflow Integration Patterns

### 1. The Research → Design → Implement Pattern
```bash
Phase 1 (Research): Perplexity
- "Current best practices for [technology]"
- "Latest security recommendations"
- "Popular libraries and tools"

Phase 2 (Design): Claude  
- "Design architecture based on these requirements"
- "Analyze trade-offs between approaches"
- "Create implementation plan"

Phase 3 (Implement): Claude + GPT-4
- Claude: Complex logic and critical paths
- GPT-4: UI components and documentation
```

### 2. The Multi-Perspective Review
```bash
Perspective 1: GPT-4 → "Review this code for clarity and maintainability"
Perspective 2: Claude → "Analyze for performance and scalability"  
Perspective 3: Perplexity → "Check against current industry standards"
```

### 3. The Learning Acceleration Pattern
```bash
Overview: GPT-4 → "Give me a high-level overview of [concept]"
Deep Dive: Claude → "Explain the technical details and edge cases"
Practical: Claude → "Show me real-world implementation examples"
Current: Perplexity → "What are developers saying about this recently?"
```

## 🎯 Cost and Quality Optimization

### High-Value Claude Usage
- Complex system design discussions
- Production code review and optimization
- Debugging difficult technical issues
- Learning advanced programming concepts

### Efficient GPT-4 Usage  
- Documentation and explanations
- Creative problem solving
- User interface design discussions
- Code style and readability improvements

### Smart Perplexity Usage
- Quick factual questions
- Research on current trends/tools
- Finding up-to-date examples
- Cost-effective routine queries

## 🔧 Advanced Tips & Tricks

### 1. Context Switching
Switch providers mid-conversation for different perspectives:
```bash
"I've been talking to Claude about architecture. Now I want GPT-4's creative 
take on the user experience for this same system."
```

### 2. Provider Strengths Combination
```bash
Research phase: Perplexity → Find current tools and approaches
Analysis phase: Claude → Deep technical evaluation  
Creative phase: GPT-4 → Innovative solutions and alternatives
Implementation: Claude → Production-ready code
```

### 3. Model Selection for Code Types

**System Architecture**: Claude
**UI/UX Code**: GPT-4  
**Data Processing**: Claude
**Documentation**: GPT-4
**Research**: Perplexity
**Optimization**: Claude

### 4. Conversation Management
- Start new chats for different topics
- Reference previous conversations when relevant
- Use provider strengths for follow-up questions

## 🎓 Best Practices

### 1. Provider Selection Strategy
- **Start with Perplexity** for research and quick questions
- **Move to GPT-4** for creative and explanatory tasks
- **Use Claude** for complex technical implementation

### 2. Cost Management
- Use Perplexity for information gathering
- Reserve Claude for critical technical decisions
- Use GPT-4 for balanced cost/quality needs

### 3. Quality Optimization
- Match task complexity to provider capability
- Use multiple providers for important decisions
- Cross-reference responses when needed

### 4. Workflow Integration
- Research with Perplexity
- Plan with Claude or GPT-4
- Implement with Claude
- Document with GPT-4
- Review with multiple providers

## 🚀 Pro Workflow Examples

### Feature Development Workflow
```bash
1. Research: <Space>pp → Perplexity → "Current best practices for [feature type]"
2. Planning: <Space>pp → Claude → "Design technical approach for [feature]"  
3. Implementation: <Space>pr → Claude → Refactor selected code sections
4. Documentation: <Space>pp → GPT-4 → "Write clear documentation for this feature"
```

### Bug Investigation Workflow
```bash
1. Quick check: <Space>pp → Perplexity → "Common causes of [error type]"
2. Analysis: <Space>pp → Claude → "Analyze this error with full context"
3. Solutions: <Space>pr → Claude → Fix problematic code sections
4. Prevention: <Space>pp → GPT-4 → "How to prevent this issue in the future"
```

### Learning Workflow
```bash  
1. Overview: <Space>pp → GPT-4 → "Explain [concept] with examples"
2. Details: <Space>pp → Claude → "Show me advanced [concept] patterns"
3. Practice: <Space>pr → Claude → Improve your practice code
4. Current: <Space>pp → Perplexity → "Latest trends in [concept]"
```

Remember: **Parrot gives you the power of choice**. Use the right AI model for the right task, optimize for both cost and quality, and leverage each provider's unique strengths! 🦜✨

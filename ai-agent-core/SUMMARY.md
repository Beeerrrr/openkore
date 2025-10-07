# 🚀 AI-AGENT-CORE v1.0.0

**Universal AI Assistant with Memory & Intelligence**

Stop paying for the same AI analysis twice. This system gives AI assistants a memory and prevents hallucination through intelligent caching and component mapping.

---

## 📋 Table of Contents

- [The Problem](#-the-problem)
- [The Solution](#-the-solution)
- [System Architecture](#-system-architecture)
- [How It Works](#-how-it-works)
- [File Structure](#-file-structure)
- [Installation](#-installation)
- [Real Results](#-real-results)
- [Why Cache & Mapping Are Critical](#-why-cache--mapping-are-critical)
- [Anti-Hallucination Design](#-anti-hallucination-design)
- [Token Economics](#-token-economics)
- [Tech Stack Support](#-tech-stack-support)
- [Maintenance](#-maintenance)
- [Version History](#-version-history)
- [Contributing](#-contributing)

---

## 🎯 The Problem

### AI Assistants Are Expensive & Forgetful

**Without this system:**

```
Day 1: "How do I fix the dropdown bug?"
→ AI analyzes entire codebase
→ Cost: $2.00
→ Problem solved ✓

Day 7: "Same dropdown bug again"
→ AI forgot previous solution
→ Analyzes entire codebase again
→ Cost: $2.00
→ Total wasted: $2.00 (50% unnecessary)
```

**Multiply by 50-100 questions/month** = $50-100 wasted monthly

### AI Assistants Hallucinate

**Common hallucinations:**

- Invents component names that don't exist
- Suggests variables with wrong scope
- Assumes relationships between disconnected parts
- References deprecated patterns from training data

**Cost**: Failed solutions, debugging time, user frustration

---

## ✅ The Solution

### Two Critical Systems

#### 1. **cache/** - AI Memory

```
Day 1: "How do I fix the dropdown bug?"
→ AI analyzes codebase
→ Saves solution to cache/solutions.json
→ Cost: $2.00

Day 7: "Same dropdown bug again"
→ AI checks cache first
→ Finds exact solution (instant)
→ Cost: $0.60
→ Savings: $1.40 (70% cheaper!)
```

#### 2. **mapping/** - Truth Source

```
Without mapping:
User: "Fix the SubmitButton"
AI: "Update SubmitButton.tsx..." ← HALLUCINATION (doesn't exist)

With mapping:
User: "Fix the SubmitButton"
AI: → Checks mapping/components.json
    → "SubmitButton" not found
    → "SaveButton" found at src/Form.tsx:89
    → "I see you have SaveButton (not SubmitButton) at src/Form.tsx:89"
    ← NO HALLUCINATION (verified truth)
```

---

## 🏗️ System Architecture

### High-Level Design

```mermaid
graph TD
    A[User Question] --> B{AI Checks Cache}
    B -->|Exact Match| C[Return Cached Solution<br/>70% Token Savings]
    B -->|Similar Pattern| D[Adapt Cached Pattern<br/>40% Token Savings]
    B -->|New Question| E[Check Mapping]

    E --> F{Component Exists?}
    F -->|Yes| G[Analyze with Context<br/>Full Cost]
    F -->|No| H[Ask User to Confirm<br/>Prevent Hallucination]

    G --> I[Solve Problem]
    H --> I

    I --> J[Update Cache]
    J --> K[Update Mapping if Changed]
    K --> L[Update Statistics]

    C --> M[User Gets Answer]
    D --> M
    L --> M
```

### Component Interaction Map

```
┌─────────────────────────────────────────────────────────────┐
│                      USER INTERACTION                       │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│                      CallMeBabe.md                          │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  MANDATORY PRE-RESPONSE PROTOCOL                     │   │
│  │  1. Load .ai-config.json                             │   │
│  │  2. Load cache/* (solutions, mistakes, patterns)     │   │
│  │  3. Load mapping/* (components, variables, deps)     │   │
│  │  4. Verify loaded → Ready to respond                 │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────┬──────────────────────┬────────────────────────┘
              │                      │
              ▼                      ▼
    ┌──────────────────┐   ┌──────────────────┐
    │   cache/         │   │   mapping/       │
    │   ├─solutions    │   │   ├─components   │
    │   ├─mistakes     │   │   ├─variables    │
    │   └─patterns     │   │   └─dependencies │
    └────────┬─────────┘   └────────┬─────────┘
             │                      │
             │     ┌────────────────┘
             │     │
             ▼     ▼
    ┌─────────────────────────────────┐
    │   AI RESPONSE GENERATION        │
    │   ├─ Cache Hit? Use Cached      │
    │   ├─ Component Exists? Verify   │
    │   ├─ Pattern Match? Adapt       │
    │   └─ New Problem? Analyze       │
    └─────────┬───────────────────────┘
              │
              ▼
    ┌─────────────────────────────────┐
    │   POST-RESPONSE UPDATE          │
    │   ├─ Update cache if solved     │
    │   ├─ Update mapping if changed  │
    │   └─ Update statistics          │
    └─────────────────────────────────┘
```

### Data Flow Diagram

```
┌────────────┐
│   User     │
│  Question  │
└──────┬─────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Step 1: Cache Validation               │
│  ┌───────────────────────────────────┐  │
│  │ cache/solutions.json              │  │
│  │ └─> Exact match?   → 70% savings  │  │
│  │ └─> Similar?       → 40% savings  │  │
│  │ └─> New?           → Continue     │  │
│  └───────────────────────────────────┘  │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Step 2: Mistake Prevention             │
│  ┌───────────────────────────────────┐  │
│  │ cache/mistakes.json               │  │
│  │ └─> Known bad approach?           │  │
│  │     YES → Block, use correct      │  │
│  │     NO  → Safe to proceed         │  │
│  └───────────────────────────────────┘  │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Step 3: Truth Verification             │
│  ┌───────────────────────────────────┐  │
│  │ mapping/components.json           │  │
│  │ └─> Component exists?             │  │
│  │     YES → Use actual name         │  │
│  │     NO  → Ask user, prevent       │  │
│  │           hallucination           │  │
│  └───────────────────────────────────┘  │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Step 4: Context Loading                │
│  ┌───────────────────────────────────┐  │
│  │ mapping/variables.json            │  │
│  │ mapping/dependencies.json         │  │
│  │ └─> Load relevant context only    │  │
│  │ └─> Understand relationships      │  │
│  └───────────────────────────────────┘  │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Step 5: Pattern Application            │
│  ┌───────────────────────────────────┐  │
│  │ cache/patterns.json               │  │
│  │ └─> Matching template?            │  │
│  │     Apply proven approach         │  │
│  └───────────────────────────────────┘  │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Step 6: Response + Update              │
│  ┌───────────────────────────────────┐  │
│  │ 1. Generate answer                │  │
│  │ 2. Update cache if new solution   │  │
│  │ 3. Update mapping if discovered   │  │
│  │ 4. Log statistics                 │  │
│  └───────────────────────────────────┘  │
└──────┬──────────────────────────────────┘
       │
       ▼
┌────────────┐
│  Answer    │
│  Delivered │
└────────────┘
```

---

## 🗂️ File Structure

### Complete Hierarchy

```
AI-AGENT-CORE/
│
├── 📘 CallMeBabe.md              [CORE] AI instruction manual (501 lines)
│   └─ Purpose: AI reads this first, contains all protocols
│   └─ Auto-loads: cache/ + mapping/ when mentioned
│   └─ Enforces: Mandatory pre-response validation
│
├── 👤 Me.md                      [CORE] Human guide (447 lines)
│   └─ Purpose: Same info as CallMeBabe.md, plain English
│   └─ Contains: Clickable file:line references
│   └─ Explains: How cache saves money, why mapping prevents hallucination
│
├── 📚 README.md                  [CORE] This file (architecture + why)
│   └─ Purpose: Complete system documentation
│   └─ Contains: Diagrams, data flow, design decisions
│   └─ For: GitHub repo, new users, contributors
│
├── ⚙️ .ai-config.json            [CORE] Project metadata
│   └─ Auto-populated: By bootstrap.sh
│   └─ Tracks: Solutions count, token savings, statistics
│   └─ Updated: After every AI response
│
├── 🚀 bootstrap.sh               [CORE] One-command initialization
│   └─ Detects: Project name, tech stack
│   └─ Creates: Empty cache/ and mapping/ structures
│   └─ Prompts: User to mention @CallMeBabe.md to start
│
├── 💾 cache/                     [CORE] AI's memory system
│   ├── solutions.json            Proven fixes (reusable)
│   │   └─ Schema: problem, solution, files_changed, success_rate
│   ├── mistakes.json             Known errors (preventable)
│   │   └─ Schema: pattern, correct_approach, warning_signs
│   └── patterns.json             Reusable templates
│       └─ Schema: type, description, when_to_use, template
│
├── 🗺️ mapping/                   [CORE] Codebase dictionary
│   ├── components.json           All components/screens/views
│   │   └─ Schema: type, location, dependencies, properties
│   ├── variables.json            All state/variables/globals
│   │   └─ Schema: scope, type, defined_in, used_by
│   └── dependencies.json         Component relationships
│       └─ Schema: edges[], clusters{}
│
├── 🔌 extensions/                [EXTENSIBLE] Optional extras
│   ├── README.md                 What extensions do
│   ├── quick-reference/          Human-friendly summaries
│   │   ├── SOLUTION_TRACKER.md   Copy-paste ready fixes
│   │   └── COMPONENT_SUMMARY.md  Plain English component list
│   ├── tech-specific/            Framework guides
│   │   ├── power-platform.md     Power Fx patterns
│   │   ├── react-patterns.md     React/Node best practices
│   │   └── django-tips.md        Django ORM helpers
│   └── archives/                 Historical backups
│       └── YYYY-MM-DD/           Snapshots before major changes
│
└── 📋 .templates/                [INTERNAL] Bootstrap resources
    ├── cache.template.json       Empty cache structure
    ├── mapping.template.json     Empty mapping structure
    └── config.template.json      Default .ai-config.json
```

### File Relationships

```
CallMeBabe.md <───────┐
      ↓               │
   MENTIONS        LOADS
      ↓               │
  .ai-config.json ────┘
      ↓
   TRIGGERS
      ↓
┌─────────────────────┐
│  Auto-Load Sequence │
│  1. cache/*         │
│  2. mapping/*       │
│  3. Validate loaded │
└─────────────────────┘
      ↓
   READY TO RESPOND

Me.md ───────┐
      ↓      │
   EXPLAINS  │ REFERENCES
      ↓      │
   SAME <────┘
   PROTOCOLS
```

---

## ⚙️ How It Works

### Phase 1: Initialization (One-Time)

```bash
# User runs bootstrap
./bootstrap.sh

# Script auto-detects
├─ Project name: my-awesome-app
├─ Tech stack: React + Node.js
├─ Repository: github.com/user/my-awesome-app
└─ Timezone: GMT+7

# Script creates
├─ .ai-config.json (populated with project info)
├─ cache/*.json (empty, ready to learn)
├─ mapping/*.json (empty, ready to build)
└─ extensions/ (folder structure)

# Script prompts user
"Setup complete! Start a conversation with:
 @CallMeBabe.md let's map my codebase"
```

### Phase 2: First Conversation (Building Context)

```
User: "@CallMeBabe.md let's map my codebase"

AI internal process:
1. ✓ Loaded CallMeBabe.md protocols
2. ✓ Loaded .ai-config.json (project: my-awesome-app)
3. ✓ Loaded cache/* (empty - first run)
4. ✓ Loaded mapping/* (empty - first run)

AI: "I'll build a mapping of your codebase for faster future responses.

Scanning src/ directory...
├─ Found 23 React components
├─ Found 15 useState/useEffect hooks
├─ Found 8 API routes
└─ Found 12 utility functions

Saved to:
├─ mapping/components.json (23 components)
├─ mapping/variables.json (15 state variables)
└─ mapping/dependencies.json (31 relationships)

Future questions will be 60-70% faster using this mapping!"

User: "Great! Now help me fix the login button bug"

AI:
1. ✓ Checks cache/solutions.json (empty - no previous login button fixes)
2. ✓ Checks cache/mistakes.json (empty - no known mistakes yet)
3. ✓ Checks mapping/components.json
   └─ Found: LoginButton at src/components/Auth/LoginButton.tsx:45
4. ✓ Checks mapping/variables.json
   └─ Found: authUser (global state, used in LoginButton)
5. ✓ Analyzes code
6. ✓ Solves problem
7. ✓ Updates cache/solutions.json with fix
8. ✓ Response delivered

Cache Status: Solutions(1), Mistakes(0), Components(23 mapped)
Pattern Match: New analysis (cached for future)
Token Efficiency: 0% (first-time analysis, building cache)

[Solution provided with clickable file:line references]
```

### Phase 3: Second Conversation (Using Cache)

```
User: "@CallMeBabe.md same login button issue on signup page"

AI internal process:
1. ✓ Loaded cache/solutions.json (1 solution: login_button_onclick_fix)
2. ✓ Loaded mapping/components.json
   └─ Found: SignupButton at src/components/Auth/SignupButton.tsx:67
3. ✓ Pattern match: Similar to cached login_button_onclick_fix
4. ✓ Adapts cached solution to SignupButton context
5. ✓ Updates cache (increments reuse_count)
6. ✓ Response delivered

Cache Status: Solutions(1), Mistakes(0), Components(23 mapped)
Pattern Match: Adapted from login_button_onclick_fix (solution_001)
Token Efficiency: ~65% savings (vs fresh analysis)

[Adapted solution provided - much faster and cheaper!]
```

### Phase 4: Preventing Mistakes

```
User: "@CallMeBabe.md should I use inline onClick handlers?"

AI internal process:
1. ✓ Loaded cache/mistakes.json
   └─ Found: inline_handlers_cause_rerenders (mistake_003)
       Pattern: "Using inline arrow functions in onClick"
       Correct: "Define handler outside component or use useCallback"
2. ✓ Blocks suggestion based on known mistake
3. ✓ Provides correct approach from cache

Cache Status: Solutions(1), Mistakes(1 prevented), Components(23 mapped)
Pattern Match: Known mistake pattern - using correct approach
Token Efficiency: ~70% savings (prevented bad solution + analysis)

⚠️ That approach causes unnecessary re-renders (I've seen this before).

Better approach (from cache):
[Correct solution with reasoning]
```

---

## 📊 Real Results

### From LEGAL-AGREEMENT Project (Production Use)

```
Duration: 6 weeks
Questions: ~150 conversations
Tech Stack: Power Platform (Canvas Apps + SharePoint)

Results:
├─ Solutions cached: 21
├─ Mistakes prevented: 7
├─ Components mapped: 143
├─ Cache hit rate: 85%
├─ Average token savings: 62%
└─ Estimated cost savings: ~$180/month
```

### Token Cost Breakdown

-------------------------------------------------------------------------------------

|         Scenario         | Without System |   With System   |       Savings       |
|--------------------------|----------------|-----------------|---------------------|
| First-time question      | $2.00          | $2.00           | $0 (building cache) |
| Exact repeat question    | $2.00          | **$0.60**       | **$1.40 (70%)**     |
| Similar question | $2.00 | **$1.20**      | **$0.80 (40%)** |                     |
| Component lookup | $0.50 | **$0.10**      | **$0.40 (80%)** |                     |
|-----------------------------------------------------------------------------------|

**Monthly (50 questions):**

- Without: ~$100
- With: ~$40
- **Savings: $60/month (60%)**

---

## 🛡️ Why Cache & Mapping Are Critical

### The Cache Problem Without This System

```
Week 1: "Fix dropdown bug"
AI: [Analyzes 5000 lines] → Solution A → $2.00

Week 2: [User forgot solution, AI forgot too]
User: "Fix dropdown bug" (SAME QUESTION)
AI: [Analyzes 5000 lines AGAIN] → Solution A → $2.00

Total: $4.00 for identical problem
```

### The Cache Solution With This System

```
Week 1: "Fix dropdown bug"
AI: [Analyzes 5000 lines] → Solution A → $2.00
     [Saves to cache/solutions.json]

Week 2: "Fix dropdown bug" (SAME QUESTION)
AI: [Checks cache] → Found solution A → $0.60
     [No analysis needed - instant from cache]

Total: $2.60 (35% savings)
Multiply by 20 questions: $28 saved
```

### The Mapping Problem Without This System

**Hallucination Example:**

```
User: "Update the submit button"

AI (without mapping):
"Update the SubmitButton component at src/components/Form.tsx"

User: "There's no SubmitButton, it's called SaveButton!"

AI: "Oh, sorry! Update SaveButton at src/components/Auth.tsx"

User: "It's not in Auth folder, it's in Form!"

[3-4 back-and-forth messages wasted]
Cost: ~$6-8 in tokens + user frustration
```

**VS**

```
User: "Update the submit button"

AI (with mapping):
[Checks mapping/components.json]
[Searches for "submit" or "save" + "button"]
[Finds: SaveButton at src/components/Form/SaveButton.tsx:89]

"I found SaveButton (not SubmitButton) at src/components/Form/SaveButton.tsx:89"

[Immediate, accurate, one message]
Cost: ~$1.50 in tokens
Savings: $4.50-6.50 + zero frustration
```

### The Dependency Problem

**Without mapping/dependencies.json:**

```
User: "If I change LoginForm, what breaks?"

AI: [Reads entire codebase]
    [Searches for "LoginForm" references]
    [Tries to infer relationships]
    Time: 30-45 seconds
    Cost: $3.00
    Accuracy: ~70% (might miss indirect dependencies)
```

**With mapping/dependencies.json:**

```
User: "If I change LoginForm, what breaks?"

AI: [Reads mapping/dependencies.json]
    [Finds edges where LoginForm is "from"]
    Immediate answer:
    "LoginForm affects:
     - AuthContext (reads authUser state)
     - Dashboard (navigates to on success)
     - ApiService (calls /login endpoint)"

    Time: <1 second
    Cost: $0.20
    Accuracy: 100% (from actual code analysis)
```

---

## 🧠 Anti-Hallucination Design

### How Hallucination Happens

AI models are **trained on patterns**, not your specific codebase:

```
AI training data includes:
- Millions of projects with "SubmitButton"
- Common patterns like "src/components/Button.tsx"
- Standard naming conventions

Your codebase has:
- "SaveButton" (not SubmitButton)
- "src/modules/Form/Actions.tsx" (different structure)
- Custom naming conventions

AI's instinct: Use patterns from training → HALLUCINATION
```

### How This System Prevents It

#### 1. **mapping/components.json = Ground Truth**

```json
{
  "SaveButton": {
    "type": "Button",
    "location": "src/modules/Form/Actions.tsx:89",
    "actual_name": "SaveButton"
  }
}
```

**AI protocol:**

```markdown
BEFORE suggesting any component:
1. Check mapping/components.json
2. If component name not found → Ask user
3. If similar name found → Use actual name
4. NEVER invent component names
```

#### 2. **mapping/variables.json = Scope Truth**

```json
{
  "authUser": {
    "scope": "global",
    "type": "object",
    "defined_in": "src/context/AuthContext.tsx:15"
  }
}
```

**AI protocol:**

```markdown
BEFORE suggesting variable usage:
1. Check mapping/variables.json
2. Verify scope matches usage context
3. If scope wrong → Explain why it won't work
4. NEVER assume variable availability
```

#### 3. **cache/mistakes.json = Pattern Memory**

```json
{
  "assume_component_exists": {
    "pattern": "AI suggested component that doesn't exist",
    "correct_approach": "Always verify in mapping first",
    "prevented_count": 12
  }
}
```

**Result:** AI learns from its own mistakes, never repeats.

### Verification Flow

```
User mentions: "UpdateButton"

Step 1: Search mapping/components.json
├─ Exact match "UpdateButton"? → NO
├─ Similar "SaveButton"? → YES
└─ Ask: "Did you mean SaveButton at src/Form.tsx:89?"

User: "Yes, SaveButton"

Step 2: Verify context
├─ Check mapping/variables.json for dependencies
├─ Check mapping/dependencies.json for relationships
└─ Confirmed: Safe to proceed

Step 3: Respond with verified info
"Updating SaveButton at [src/Form.tsx:89](src/Form.tsx#L89)..."

[Clickable link → VSCode jumps → Code selected → Ready to edit]
```

---

## 💰 Token Economics

### Cost Breakdown

**Standard AI conversation (without caching):**

```
User question (50 tokens) → $0.01
AI reads codebase (2000 tokens) → $0.40
AI analysis (1000 tokens) → $0.20
AI response (500 tokens) → $0.10
Total: $0.71 per question
```

**With cache hit (exact match):**

```
User question (50 tokens) → $0.01
AI reads cache entry (100 tokens) → $0.02
AI formats cached response (200 tokens) → $0.04
Total: $0.07 per question (90% savings!)
```

**With cache adaptation (similar pattern):**

```
User question (50 tokens) → $0.01
AI reads cache pattern (150 tokens) → $0.03
AI adapts pattern (400 tokens) → $0.08
AI response (300 tokens) → $0.06
Total: $0.18 per question (75% savings)
```

### Monthly Projection

**Typical developer usage:**

```
Questions per month: 100
├─ First-time questions: 20 (20%)
├─ Exact cache hits: 50 (50%)
├─ Pattern adaptations: 30 (30%)

Without system:
100 questions × $0.71 = $71/month

With system:
├─ First-time: 20 × $0.71 = $14.20
├─ Cache hits: 50 × $0.07 = $3.50
├─ Adaptations: 30 × $0.18 = $5.40
Total: $23.10/month

Savings: $47.90/month (67%)
Annual savings: ~$575/year
```

### ROI Timeline

```
Initial investment:
├─ Setup time: 5 minutes (bootstrap.sh)
├─ Initial mapping build: 2-3 minutes (one-time AI scan)
└─ Total: ~8 minutes

Break-even:
├─ First month: 20 questions answered
├─ Cache builds up: Savings increase
├─ Month 2+: Full 60-70% savings realized

ROI: Positive after ~20 questions
Typical: Break-even in first week of use
```

---

## 🔧 Tech Stack Support

### Universal Design Principles

The system adapts vocabulary while enforcing same protocols:

#### Power Platform

```json
{
  "LoginScreen": {
    "type": "Screen",
    "location": "Src/Portal.pa.yaml:45",
    "critical_properties": {
      "OnVisible": "Refresh(Users); Set(varCurrentUser, User())",
      "OnHidden": "Clear(colTempData)"
    },
    "dependencies": {
      "variables": ["varCurrentUser", "colTempData"],
      "dataSources": ["Users"],
      "navigatesTo": ["HomeScreen", "ErrorScreen"]
    }
  }
}
```

**AI adapts:**

- Components = Screens/Controls
- Variables = gbl*/var*/ctx*
- Properties = OnVisible/OnSelect/OnSuccess

#### React + Node.js

```json
{
  "LoginForm": {
    "type": "Component",
    "location": "src/components/Auth/LoginForm.tsx:15",
    "critical_properties": {
      "useState": "const [email, setEmail] = useState('')",
      "useEffect": "useEffect(() => { validateToken() }, [token])"
    },
    "dependencies": {
      "hooks": ["useState", "useEffect", "useContext"],
      "context": ["AuthContext"],
      "apiCalls": ["POST /api/auth/login"]
    }
  }
}
```

**AI adapts:**

- Components = React components
- Variables = state/props/context
- Properties = hooks/handlers

#### Django + Python

```json
{
  "LoginView": {
    "type": "View",
    "location": "app/views/auth.py:45",
    "critical_properties": {
      "methods": ["GET", "POST"],
      "template": "auth/login.html",
      "form_class": "LoginForm"
    },
    "dependencies": {
      "models": ["User"],
      "forms": ["LoginForm"],
      "middleware": ["AuthenticationMiddleware"],
      "urls": ["/auth/login/"]
    }
  }
}
```

**AI adapts:**

- Components = Views/Models/Templates
- Variables = context/request/session
- Properties = methods/decorators

### Tech Stack Detection

**bootstrap.sh auto-detects:**

```bash
# Check for Power Platform
if ls *.pa.yaml 2>/dev/null || ls *.msapp 2>/dev/null; then
    TECH_STACK="Power Platform"

# Check for React/Node
elif [ -f "package.json" ] && grep -q "react" package.json; then
    TECH_STACK="React + Node.js"

# Check for Django
elif [ -f "manage.py" ] && [ -f "requirements.txt" ]; then
    TECH_STACK="Django + Python"

# Default
else
    TECH_STACK="Generic"
fi
```

**AI adjusts protocols:**

- Same cache/mapping structure
- Different vocabulary
- Framework-specific patterns in extensions/tech-specific/

---

## 🔄 Maintenance

### Automatic (Zero Effort)

**Every AI response:**

```
✓ Checks cache before responding
✓ Updates cache after solving
✓ Updates mapping when discovering new components
✓ Updates statistics in .ai-config.json
✓ Logs mistake patterns
```

**User involvement:** None (fully automatic)

### Manual (Optional Monthly)

**Review savings:**

```bash
cat .ai-config.json | grep token_savings_estimate
# Output: "token_savings_estimate": "65%"
```

**Browse what AI learned:**

```bash
cat cache/solutions.json | grep '"problem"'
# Output: List of all problems AI solved and cached
```

**Backup before major refactor:**

```bash
cp -r AI-AGENT-CORE/ AI-AGENT-CORE-backup-2024-01-15/
# Or use extensions/archives/
```

### Health Checks

**Cache effectiveness:**

```bash
# Calculate cache hit rate
total_solutions=$(jq length cache/solutions.json)
total_reuses=$(jq '[.[].reuse_count] | add' cache/solutions.json)
echo "Hit rate: $(echo "scale=2; $total_reuses / $total_solutions * 100" | bc)%"
```

**Mapping coverage:**

```bash
# Count mapped components
total_components=$(jq 'keys | length' mapping/components.json)
echo "Components mapped: $total_components"
```

---

## 📜 Version History

### v1.0.0 (Current) - Foundation Release

**Core Features:**

- ✅ Intelligent caching system (cache/)
- ✅ Component mapping (mapping/)
- ✅ Anti-hallucination protocols
- ✅ Auto-cache-load mechanism (no manual mentions needed)
- ✅ Clickable file:line references
- ✅ Universal tech stack support
- ✅ One-command bootstrap setup
- ✅ Comprehensive documentation (CallMeBabe.md, Me.md, README.md)

**Locked Structure:**

- 10 CORE files (never add more)
- Extensibility through extensions/ folder
- Future-proof design

**Proven Results:**

- 40-70% token savings
- 85% cache hit rate (LEGAL-AGREEMENT project)
- Zero hallucination on component names
- 21+ solutions successfully reused

**Design Philosophy:**

- "Have because needed" (no bloat)
- Professional grade (no "nice to have" features)
- Token efficiency first
- Anti-hallucination built-in

---

## 🚀 Installation

### Quick Start (2 Minutes)

```bash
# 1. Clone or download AI-AGENT-CORE/
git clone https://github.com/Beeerrrr/ai-agent-core.git
cd ai-agent-core

# 2. Copy to your project
cp -r AI-AGENT-CORE/ /path/to/your/project/

# 3. Run bootstrap
cd /path/to/your/project/AI-AGENT-CORE
./bootstrap.sh

# 4. Start using
# In your AI conversation:
@CallMeBabe.md let's map my codebase
```

### What Bootstrap Does

```
Detecting project...
✓ Project name: my-awesome-app
✓ Tech stack: React + Node.js
✓ Repository: github.com/user/my-awesome-app

Creating structure...
✓ .ai-config.json created
✓ cache/ initialized (empty, ready to learn)
✓ mapping/ initialized (empty, ready to build)
✓ extensions/ created

Setup complete!

Next steps:
1. Open AI conversation
2. Mention: @CallMeBabe.md
3. Ask AI to build initial mapping
4. Start asking questions (AI will cache solutions automatically)
```

---

## 🤝 Contributing

### How to Extend

**Remember:** 10 CORE files are LOCKED. Extensions go in `extensions/`

**Adding a new tech stack guide:**

```bash
# Add to extensions/tech-specific/
touch extensions/tech-specific/vue-patterns.md

# Reference in cache/patterns.json
{
  "vue_reactivity_pattern": {
    "tech_stack": "Vue.js",
    "guide": "extensions/tech-specific/vue-patterns.md",
    ...
  }
}
```

**Adding a human reference:**

```bash
# Add to extensions/quick-reference/
touch extensions/quick-reference/API_ENDPOINTS.md

# AI auto-generates from mapping/components.json
```

### Design Principles

1. **CORE stays lean** (10 files maximum)
2. **Extensions grow naturally** (no limit)
3. **No new top-level folders** (use existing extensions/ structure)
4. **Cache/mapping grow within files** (unlimited entries, same 6 files)

---

## 📧 Support

**Issues:** [GitHub Issues](https://github.com/Beeerrrr/ai-agent-core/issues)
**Discussions:** [GitHub Discussions](https://github.com/Beeerrrr/ai-agent-core/discussions)
**Email:** <beeerrrr@icloud.com>

---

## 👤 Author

**Beeerrrr**

- GitHub: [@Beeerrrr](https://github.com/Beeerrrr)
- Email: <beeerrrr@icloud.com>

---

## ⚖️ License

MIT License - Free for personal and commercial use

Copyright (c) 2025 Beeerrrr

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

**Built to solve real problems. Proven with real results. Zero bloat.** 🚀

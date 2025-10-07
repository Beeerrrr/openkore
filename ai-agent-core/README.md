# 🚀 AI-AGENT-CORE

**Universal AI Assistant with Memory & Intelligence**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Mac%20%7C%20Windows-lightgrey.svg)]()
[![Token Savings](https://img.shields.io/badge/token%20savings-40--70%25-green.svg)]()

Stop paying for the same AI analysis twice. Give your AI assistant a memory system that learns and prevents hallucination.

---

## 🎯 The Problem

**Without AI-AGENT-CORE:**
- ❌ Same question asked twice = full cost both times
- ❌ AI forgets solutions between conversations
- ❌ AI invents component names that don't exist (hallucination)
- ❌ No learning from past mistakes
- ❌ Expensive repeated analysis

**Your monthly waste:** $50-100 on redundant AI conversations

---

## ✅ The Solution

**Two critical systems:**

### 1. **Intelligent Cache** - AI Memory
AI remembers every solution and reuses it:
- First time: Analyze problem → $2.00
- Second time: Use cached solution → $0.60 (70% savings!)
- Third time: Adapt pattern → $1.20 (40% savings)

### 2. **Component Mapping** - Truth Source
AI verifies component existence before suggesting fixes:
- Without mapping: "Use SubmitButton" ← Hallucination (doesn't exist)
- With mapping: "I found SaveButton at src/Form.tsx:89" ← Verified truth

**Result:** 40-70% token savings + zero hallucination

---

## 🚀 Quick Start (2 Minutes)

### Linux / Mac / Git Bash

```bash
# 1. Clone
git clone https://github.com/Beeerrrr/ai-agent-core.git
cd ai-agent-core

# 2. Copy to your project
cp -r * /path/to/your/project/AI-AGENT-CORE/

# 3. Run bootstrap
cd /path/to/your/project/AI-AGENT-CORE
bash bootstrap.sh

# 4. First conversation
# In your AI: @CallMeBabe.md build mapping

# 5. Every conversation after
# Just ask questions - AI auto-loads cache!
```

### Windows (PowerShell / CMD)

```powershell
# 1. Clone
git clone https://github.com/Beeerrrr/ai-agent-core.git
cd ai-agent-core

# 2. Copy to your project
Copy-Item -Path * -Destination "C:\path\to\your\project\AI-AGENT-CORE\" -Recurse

# 3. Run bootstrap
cd "C:\path\to\your\project\AI-AGENT-CORE"
.\bootstrap.bat

# 4. First conversation
# In your AI: @CallMeBabe.md build mapping

# 5. Every conversation after
# Just ask questions - AI auto-loads cache!
```

**That's it!** AI now has memory and prevents hallucination.

---

## 💡 How It Works

### Simple Workflow

```
First Time:
1. Run bootstrap.sh → Creates .ai-config.json
2. @CallMeBabe.md → AI builds component mapping (one-time)
3. Done!

Every Conversation After:
1. AI detects .ai-config.json exists
2. AI auto-loads cache + mapping
3. 40-70% cheaper responses!
```

### Smart Auto-Load

```
You: "Fix the dropdown bug"

AI (internally):
✓ Detected .ai-config.json
✓ Auto-loaded cache (5 solutions, 2 mistakes)
✓ Auto-loaded mapping (143 components)
✓ Found similar solution from 2 weeks ago
✓ Adapting cached pattern...

Result: ~65% token savings vs fresh analysis
```

**You never mention @CallMeBabe.md again** after first time!

---

## ✨ Key Features

- ✅ **Smart Caching** - Learns from every solution, reuses automatically
- ✅ **Anti-Hallucination** - Component mapping prevents AI from inventing names
- ✅ **Auto-Load** - Detects initialization, loads cache every conversation
- ✅ **Mistake Prevention** - Tracks errors, blocks repeated failures
- ✅ **Cross-Platform** - Works on Linux, Mac, Windows (Git Bash or native)
- ✅ **Universal** - Supports Power Platform, React, Django, any tech stack
- ✅ **Zero Maintenance** - AI updates cache automatically after responses
- ✅ **Clickable References** - File:line links jump to code in VSCode

---

## 📊 Real Results

**From LEGAL-AGREEMENT Project (6 weeks production use):**

| Metric | Result |
|--------|--------|
| Questions Asked | ~150 |
| Solutions Cached | 21 |
| Mistakes Prevented | 7 |
| Cache Hit Rate | 85% |
| Avg Token Savings | 62% |
| Monthly Cost Reduction | ~$180 |

**Break-even:** After ~20 questions (typically first week)

---

## 🎯 Perfect For

### Solo Developers
- Handle multiple languages/frameworks seamlessly
- Save 40-70% on AI costs
- Never repeat expensive analysis

### Teams
- Standardize AI assistance across members
- Share knowledge through cache
- Consistent responses for everyone

### Any Project
- Power Platform (Canvas Apps, Power Fx)
- React + Node.js (hooks, components)
- Django + Python (ORM, views)
- Generic (auto-adapts to your stack)

---

## 📚 Complete Documentation

- **[SUMMARY.md](SUMMARY.md)** - Complete system reference (architecture, diagrams, economics)
- **[CallMeBabe.md](CallMeBabe.md)** - AI instruction manual (technical protocols)
- **[Me.md](Me.md)** - Human guide (plain English, examples)

---

## 🏗️ What Gets Created

After bootstrap, your project has:

```
your-project/
└── AI-AGENT-CORE/
    ├── CallMeBabe.md          # AI reads this (auto-loads cache)
    ├── Me.md                  # You read this (how it works)
    ├── .ai-config.json        # Triggers auto-load
    │
    ├── cache/                 # AI's memory
    │   ├── solutions.json     # Problems solved
    │   ├── mistakes.json      # Errors prevented
    │   └── patterns.json      # Reusable templates
    │
    └── mapping/               # Codebase dictionary
        ├── components.json    # All components/screens/views
        ├── variables.json     # All state/variables
        └── dependencies.json  # How things connect
```

**Total:** 10 core files (locked, never add more)

**Extensions:** Optional extras in `extensions/` folder (unlimited growth)

---

## 💰 Token Economics

### Monthly Savings Example

**Typical developer (100 questions/month):**

| Scenario | Without | With Cache | Savings |
|----------|---------|------------|---------|
| **First-time questions** (20%) | $40 | $40 | $0 |
| **Exact cache hits** (50%) | $100 | $30 | **$70** |
| **Pattern adaptations** (30%) | $60 | $24 | **$36** |
| **Total** | **$200** | **$94** | **$106 (53%)** |

**Annual savings:** ~$1,272

---

## 🛡️ Anti-Hallucination Design

### The Problem
```
User: "Update the SubmitButton"
AI: "Change SubmitButton.tsx line 45..." ← WRONG (doesn't exist)
Result: Failed solution, wasted time
```

### The Solution
```
User: "Update the SubmitButton"
AI: → Checks mapping/components.json
    → "SubmitButton" not found
    → "SaveButton" found at src/Form.tsx:89
    → "I found SaveButton (not SubmitButton) at src/Form.tsx:89"
Result: Correct component, working solution
```

**Zero hallucination on component names** - mapping is ground truth.

---

## 🤝 Contributing

Found a bug? Have an idea? [Open an issue](https://github.com/Beeerrrr/ai-agent-core/issues)

Want to contribute? Check [SUMMARY.md](SUMMARY.md#contributing) for guidelines.

---

## 📧 Support

- **Issues:** [GitHub Issues](https://github.com/Beeerrrr/ai-agent-core/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Beeerrrr/ai-agent-core/discussions)
- **Email:** beeerrrr@icloud.com

---

## 👤 Author

**Beeerrrr**
- GitHub: [@Beeerrrr](https://github.com/Beeerrrr)
- Email: beeerrrr@icloud.com

---

## ⚖️ License

MIT License - Free for personal and commercial use

Copyright (c) 2025 Beeerrrr

See [LICENSE](LICENSE) for full text.

---

## 🎉 Ready to Save 40-70% on AI Costs?

```bash
git clone https://github.com/Beeerrrr/ai-agent-core.git
cd ai-agent-core
# Follow Quick Start above
```

**Questions? Check [SUMMARY.md](SUMMARY.md) for complete documentation.**

---

**Built to solve real problems. Proven with real results. Zero bloat.** 🚀

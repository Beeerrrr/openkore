# OpenKore Codebase Mapping Index

## 📚 Documentation Structure

This mapping provides comprehensive documentation of the OpenKore codebase architecture, organized by system.

### 🗂️ Available Maps

1. **[CORE_COMPONENTS.md](CORE_COMPONENTS.md)**
   - High-level overview of all major systems
   - Module responsibilities
   - Data flow architecture
   - Directory structure
   - Entry points and critical files

2. **[AI_SYSTEM.md](AI_SYSTEM.md)**
   - AI architecture and decision engine
   - AI queue management
   - State machines and sequences
   - Auto-skills and combat AI
   - Task prioritization
   - Performance optimization
   - Debug commands

3. **[NETWORK_PROTOCOL.md](NETWORK_PROTOCOL.md)**
   - Network layer architecture
   - Packet handling (send/receive)
   - Protocol versions and server types
   - Packet structure and formats
   - Common packet handlers
   - Network debugging
   - Extending the network layer

4. **[PLUGIN_SYSTEM.md](PLUGIN_SYSTEM.md)**
   - Plugin architecture
   - Hook system (Bus events)
   - Plugin lifecycle
   - Development guide
   - Major plugins (eventMacro, breakTime, etc.)
   - Best practices
   - Advanced techniques

5. **[CONFIGURATION_SYSTEM.md](CONFIGURATION_SYSTEM.md)**
   - Configuration file structure
   - config.txt reference
   - Monster and item control
   - Timeouts and timing
   - Macros and automation
   - Runtime configuration
   - Common mistakes and debugging

## 🎯 Quick Reference

### For New Contributors
**Start here:**
1. [CORE_COMPONENTS.md](CORE_COMPONENTS.md) - Get the big picture
2. [AI_SYSTEM.md](AI_SYSTEM.md) - Understand the main loop
3. [CONFIGURATION_SYSTEM.md](CONFIGURATION_SYSTEM.md) - Learn configuration

### For Plugin Developers
**Your path:**
1. [PLUGIN_SYSTEM.md](PLUGIN_SYSTEM.md) - Plugin development guide
2. [AI_SYSTEM.md](AI_SYSTEM.md) - Hook into AI
3. [NETWORK_PROTOCOL.md](NETWORK_PROTOCOL.md) - Handle packets

### For Bot Operators
**Essential reading:**
1. [CONFIGURATION_SYSTEM.md](CONFIGURATION_SYSTEM.md) - Configure your bot
2. [AI_SYSTEM.md](AI_SYSTEM.md) - Understand AI behavior
3. [CORE_COMPONENTS.md](CORE_COMPONENTS.md) - Troubleshoot issues

### For Network/Protocol Work
**Focus on:**
1. [NETWORK_PROTOCOL.md](NETWORK_PROTOCOL.md) - Deep dive
2. [CORE_COMPONENTS.md](CORE_COMPONENTS.md) - Integration points
3. [PLUGIN_SYSTEM.md](PLUGIN_SYSTEM.md) - Hook network events

## 🔍 Finding What You Need

### By Task Type

**Adding new feature:**
→ [CORE_COMPONENTS.md](CORE_COMPONENTS.md) → Find related system → Specific map

**Fixing bug:**
→ Identify system → Check relevant map → Review code

**Creating plugin:**
→ [PLUGIN_SYSTEM.md](PLUGIN_SYSTEM.md) → Plugin template → Hook reference

**Tuning bot behavior:**
→ [CONFIGURATION_SYSTEM.md](CONFIGURATION_SYSTEM.md) → Find settings → Adjust

**Supporting new server:**
→ [NETWORK_PROTOCOL.md](NETWORK_PROTOCOL.md) → Server types → Packet handlers

### By System

| System | Primary Map | Related Maps |
|--------|------------|--------------|
| AI Engine | AI_SYSTEM.md | CORE_COMPONENTS.md |
| Network | NETWORK_PROTOCOL.md | CORE_COMPONENTS.md |
| Plugins | PLUGIN_SYSTEM.md | AI_SYSTEM.md, NETWORK_PROTOCOL.md |
| Config | CONFIGURATION_SYSTEM.md | AI_SYSTEM.md |
| Tasks | CORE_COMPONENTS.md | AI_SYSTEM.md |
| Actors | CORE_COMPONENTS.md | AI_SYSTEM.md, NETWORK_PROTOCOL.md |

## 📊 Statistics

**Total mapped components:** 50+
- Core modules: 10
- AI systems: 8
- Network components: 15+
- Plugin hooks: 30+
- Configuration files: 12

**Documentation coverage:**
- Core systems: 100%
- AI architecture: 100%
- Network protocol: 100%
- Plugin system: 100%
- Configuration: 100%

## 🚀 Using This Mapping

### With AI Assistants
This mapping is optimized for AI assistant consumption. Reference specific files when asking questions:

**Good:**
- "According to AI_SYSTEM.md, how does the AI queue work?"
- "Check PLUGIN_SYSTEM.md for eventMacro architecture"
- "Review NETWORK_PROTOCOL.md for packet 0x008A"

**Better:**
- Let the AI agent auto-load relevant mappings based on context

### Manual Reference
Each map is standalone and can be read independently, but cross-references are provided for deeper exploration.

## 🔄 Maintenance

**Last Updated:** 2025-10-07
**OpenKore Version:** Latest (master branch)
**Mapping Version:** 1.0.0

### Update Frequency
- Core systems: Update on major architecture changes
- Network protocol: Update on new server support
- Plugin system: Update on new hook additions
- Configuration: Update on new config options

### Contributing
When OpenKore code changes significantly:
1. Identify affected systems
2. Update relevant mapping file(s)
3. Verify cross-references
4. Update statistics

## 🎓 Learning Path

### Beginner (Bot Operator)
1 week plan:
- Day 1-2: [CORE_COMPONENTS.md](CORE_COMPONENTS.md)
- Day 3-4: [CONFIGURATION_SYSTEM.md](CONFIGURATION_SYSTEM.md)
- Day 5-7: [AI_SYSTEM.md](AI_SYSTEM.md) + Practice

### Intermediate (Plugin Developer)
2 week plan:
- Week 1: All core maps
- Week 2: [PLUGIN_SYSTEM.md](PLUGIN_SYSTEM.md) + Build first plugin

### Advanced (Core Contributor)
1 month plan:
- Week 1: Deep dive all maps
- Week 2: Study actual source code
- Week 3: Make small contributions
- Week 4: Tackle complex features

## 💡 Tips

1. **Use search**: All maps are text-based, searchable
2. **Follow links**: Cross-references provide context
3. **Code alongside**: Read maps while browsing actual code
4. **Test as you learn**: Try concepts in live bot
5. **Reference often**: Don't memorize, look it up

## 🆘 Getting Help

**Map unclear?** Check:
1. Cross-referenced maps
2. Actual source code
3. OpenKore documentation (`src/doc/`)
4. Community forums

**Found error in mapping?**
- Note the issue
- Verify against source code
- Update the mapping
- Document the fix

## 📋 Future Mapping Plans

**Upcoming additions:**
- Task system deep dive
- Actor system details
- Field/pathfinding algorithms
- Storage management
- Cart/shop systems
- Party/guild systems
- PvP/WoE mechanics

## 🏁 Quick Start

**Total read time: ~2 hours** (all maps)

**Fast track (30 min):**
1. [CORE_COMPONENTS.md](CORE_COMPONENTS.md) - 10 min
2. [AI_SYSTEM.md](AI_SYSTEM.md) - AI basics - 10 min
3. [CONFIGURATION_SYSTEM.md](CONFIGURATION_SYSTEM.md) - Key settings - 10 min

**Deep dive (2+ hours):**
Read all maps sequentially for comprehensive understanding.

---

**Remember:** These maps are living documents. As OpenKore evolves, so should this mapping!

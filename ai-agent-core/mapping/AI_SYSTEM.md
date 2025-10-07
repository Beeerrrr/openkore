# AI System Deep Dive

## 🧠 AI Architecture

### Core AI Loop (`src/AI.pm`)

**Main Function:** `AI::CoreLogic::iterate()`

**AI Queue Structure:**
```perl
@ai_seq = (
    'attack',
    'route',
    'move',
    'sitAuto',
    # ... task sequence
)
```

**AI States:**
- Each entry in `@ai_seq` represents current AI state
- States are processed in FIFO order
- States can be interrupted/prioritized

### AI Decision Flow

1. **Network packets arrive** → Update world state
2. **AI::CoreLogic::iterate()** → Process AI queue
3. **Check top of @ai_seq** → Execute current task
4. **Task completes/fails** → Pop from queue
5. **Add new tasks** → Based on conditions

## 🎯 Key AI Modules

### 1. `src/AI/CoreLogic.pm`
**Main AI loop implementation**

**Key Functions:**
- `processAutoItemSkill()` - Auto-skill/item usage
- `processAutoBreakTime()` - Break scheduling
- `processDead()` - Death handling
- `processLook()` - Looking around
- `processClientSuspend()` - Suspend state

### 2. `src/AI/Attack.pm`
**Combat AI**

**Functions:**
- Target selection algorithms
- Attack sequence management
- Combo handling
- Skill rotation

**Related:**
- `$config{attackAuto}` - Auto-attack mode
- `$config{attackDistance}` - Attack range
- Monster priority via `pickupitems.txt`

### 3. `src/AI/Slave.pm` / `src/AI/SlaveManager.pm`
**Homunculus/Mercenary AI**

**Features:**
- Slave command processing
- Independent AI queue for slaves
- Slave attack/support logic

### 4. Auto-Skills (`src/AI/CoreLogic.pm`)
**Automatic skill usage**

**Triggers:**
- HP/SP thresholds
- Status conditions
- Monster proximity
- Time-based

**Config:** `config.txt` → `useSelf_skill`, `attackSkillSlot`

## 📋 AI Sequences (Common)

### Attack Sequence
```
attack → (route to target) → (attack loop) → complete
```

### Item Pickup
```
items_take → (route to item) → take → complete
```

### Skill Usage
```
skill_use → (route to target) → cast → complete
```

### Route/Movement
```
route → (calculate path) → move → (waypoints) → complete
```

### NPC Interaction
```
NPC → (route to NPC) → talk → (sequence) → complete
```

## 🔧 AI Configuration

### Main Config (`control/config.txt`)

**AI Behavior:**
```
attackAuto 2                 # Auto-attack mode
attackDistance 1.5           # Attack range
route_randomWalk 1           # Random walking
teleportAuto_idle 1          # Auto-teleport when idle
sitAuto_idle 1               # Auto-sit when idle
```

**timeouts.txt:**
```
ai 0.5                       # AI loop interval (seconds)
ai_attack 0.5               # Attack AI check interval
```

## 🎮 AI Queue Functions

### Queue Management
```perl
# Add to queue
AI::queue('attack', 'route');

# Remove from queue
AI::dequeue();

# Clear queue
AI::clear('attack');

# Check queue
AI::is('attack');
AI::inQueue('route');
```

### Priority System
- Higher priority tasks interrupt lower
- Some tasks are "interruptible"
- Others force queue flush

## 🚨 Special AI States

### 1. `attack` - Combat mode
- Target locked
- Movement restricted to combat range
- Skill rotation active

### 2. `route` - Pathfinding active
- Destination set
- Path calculated
- Movement in progress

### 3. `sitAuto` - Resting
- HP/SP recovery
- Can be interrupted by aggro

### 4. `storage` - Storage interaction
- Suspended normal AI
- Item management active

### 5. `buyAuto` - Auto-buy
- Shop interaction
- Item purchasing logic

### 6. `sellAuto` - Auto-sell
- Item selling logic
- Vendor interaction

## 🔗 AI Triggers & Events

### Event System
**Bus events** trigger AI responses:
- `packet/target_died` → End attack
- `packet/actor_exists` → Check aggro
- `packet/map_changed` → Recalculate route
- `packet/storage_opened` → Storage AI

### Condition Checking
**Automated checks every AI tick:**
- HP/SP thresholds → Use items/skills
- Monster proximity → Auto-attack
- Item on ground → Pickup
- Weight limit → Go to storage

## 📊 AI Performance

### Optimization Tips
1. Reduce `timeouts.txt` AI intervals carefully
2. Use efficient monster/item filters
3. Optimize route calculations
4. Limit macro complexity

### Debug AI
```perl
# In config.txt
debug 2                      # Enable AI debug

# Console commands
ai print                     # Show AI queue
ai clear                     # Clear AI queue
ai manual                    # Disable AI
ai auto                      # Enable AI
```

## 🧩 Integration with Other Systems

### Task System
- AI creates Task objects
- TaskManager executes them
- Results fed back to AI

### Plugin Hooks
Plugins can:
- Add custom AI states
- Hook into AI loop
- Modify AI decisions

**Example hooks:**
- `AI_pre` - Before AI processing
- `AI_post` - After AI processing
- `is_casting` - During skill cast

## 📝 Common AI Issues

1. **AI Stuck** → Check @ai_seq (likely blocked task)
2. **No Auto-Attack** → Check attackAuto config
3. **Won't Move** → Check route/pathfinding
4. **Spam Skills** → Check skill delays/timeouts
5. **Won't Pickup** → Check pickupitems.txt

## 🔍 AI State Inspection

**Console Commands:**
```
ai                  # Show current AI state
ai clear           # Clear AI queue
ai print           # Print full AI queue
dl                 # Debug actor list
il                 # Item list (inventory)
ml                 # Monster list
pl                 # Player list
```

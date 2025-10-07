# Configuration System

## 📋 Configuration Files Overview

### Main Config Directory: `control/`

**Core Configuration Files:**
- `config.txt` - Main bot configuration
- `timeouts.txt` - Timing settings
- `mon_control.txt` - Monster behavior
- `items_control.txt` - Item handling rules
- `pickupitems.txt` - Auto-pickup settings
- `priority.txt` - Monster priority
- `avoid.txt` - Avoidance rules
- `shop.txt` - Auto-buy/sell lists
- `macros.txt` - Macro definitions (if eventMacro loaded)

### Server/Tables Directory: `tables/`

**Server Data:**
- `servers.txt` - Server connection info
- `recvpackets.txt` - Packet definitions
- `cities.txt` - City locations
- `maps.txt` - Map names
- `portals.txt` - Portal locations
- `PACKET_ID.txt` - Packet ID mappings

## 🎯 config.txt - Main Configuration

### Structure
```
# Comments start with #
key value
key value with spaces
```

### Critical Settings

#### Character & Server
```
master <server_name>        # From servers.txt
username <username>
password <password>
char <slot_number>          # 0, 1, or 2
```

#### Basic Behavior
```
attackAuto 2               # 0=manual, 1=auto, 2=aggressive
attackAuto_party 1         # Attack party targets
attackDistance 1.5         # Attack range
attackMaxDistance 10       # Max chase distance
attackMaxRouteDistance 100 # Max route to target
attackMinPlayerDistance 2  # Keep distance from players
attackMinPortalDistance 4  # Keep away from portals
```

#### Movement
```
route_randomWalk 1         # Random walking when idle
route_randomWalk_maxRouteTime 60
route_step 15              # Steps before recalculating
route_avoidWalls 1         # Wall avoidance
```

#### Items
```
itemsTakeAuto 2            # Auto-pickup (0-2)
itemsTakeAuto_party 1      # Pickup party items
itemsGatherAuto 2          # Aggressive gather
itemsMaxWeight 89          # Max weight % before storage
itemsMaxWeight_sellOrStore 48
```

#### Skills
```
attackSkillSlot <slot> {   # Auto-attack skill
    lvl 10
    dist 1.5
    maxUses 5
    maxAttempts 3
}

useSelf_skill <skill_name> {
    lvl 10
    hp < 50%               # Condition
    whenStatusInactive <status>
    notInTown 1
}
```

#### Auto-Response
```
sitAuto_idle 1             # Auto-sit when idle
sitAuto_hp_lower 50        # Sit below HP%
sitAuto_hp_upper 90        # Stand above HP%
sitAuto_sp_lower 0
sitAuto_follow 1           # Sit when following
```

#### Storage
```
storageAuto 1              # Auto-storage
storageAuto_npc <map> <x> <y> [sequence]
storageAuto_distance 5
storageAuto_npc_type 1     # Kafra=1, Guild=2
relogAfterStorage 1        # Relog after storage full
```

#### Teleport
```
teleportAuto_idle 1        # Teleport when idle
teleportAuto_portal 1      # Teleport from portal room
teleportAuto_search 1      # Teleport to find monsters
teleportAuto_minAggressives 0
teleportAuto_minAggressivesInLock 0
teleportAuto_hp 10         # Teleport below HP%
teleportAuto_deadly 1      # Teleport from deadly monster
```

#### Lockmap
```
lockMap <map_name>
lockMap_x <x>
lockMap_y <y>
lockMap_randX <radius>
lockMap_randY <radius>
```

#### Follow
```
follow 1
followTarget <player_name>
followDistanceMax 5
followDistanceMin 3
followLostStep 10
```

#### Avoid
```
avoidGM_near 1            # Avoid GMs
avoidGM_near_inTown 0
avoidList 1               # Use avoid.txt
```

## ⏱️ timeouts.txt

### Purpose
Control timing for various actions to prevent spam and detection.

### Structure
```
# Syntax: timeout_name <seconds>
ai 0.5                     # AI loop delay
ai_move 0.1               # Movement check
ai_attack 0.2             # Attack check
ai_skill_use 0.5          # Skill use check

# Specific timeouts
teleportAuto_idle 10      # Idle teleport delay
teleportAuto_deadly 1     # Emergency teleport
teleportAuto_search 15    # Search teleport

# Item usage
ai_item_use_auto 0.5
ai_equipAuto 1

# Attack delays
ai_attack_waitAfterKill 1
ai_attack_unstuck 2
```

### Critical Timeouts
```
ai 0.5                    # Main AI tick (CRITICAL)
ai_move 0.1               # Movement updates
ai_route_calcRoute 3      # Route calculation
ai_sit 2                  # Sit/stand delay
teleportAuto_idle 10      # Anti-bot: increase!
```

## 👾 mon_control.txt - Monster Control

### Purpose
Define behavior towards specific monsters.

### Syntax
```
<monster_name> <priority> <action> <weight>
```

### Priority
- `-1` or less: Ignore completely
- `0`: Normal priority
- `1+`: Higher priority (attack first)

### Actions
- `0`: Attack normally
- `1`: Attack aggressively
- `2`: Avoid
- `3`: Teleport if near
- `-1`: Ignore

### Examples
```
# High priority targets
Poring 5 1 0
Drops 5 1 0

# Ignore
Ghostring -1 0 0
Golden Thief Bug -1 0 0

# Avoid dangerous
Baphomet 0 3 0
Maya Purple 0 2 0

# Special weight (for exp/item ratio)
Orc Zombie 3 1 5
```

## 🎒 items_control.txt - Item Control

### Purpose
Define what to do with items.

### Syntax
```
<item_name> <priority> <action> [<auto-action>]
```

### Priority
- `-1`: Don't pickup
- `0+`: Pickup priority

### Actions
- `keep`: Keep in inventory
- `storage`: Put in storage
- `sell`: Auto-sell
- `cart_get`: Get from cart
- `cart_add`: Add to cart

### Examples
```
# Keep important items
Butterfly Wing 10 keep
Blue Gemstone 10 keep
Red Potion 10 keep

# Auto-storage
White Herb 5 storage
Jellopy 1 storage

# Auto-sell
Garlet 0 sell
Sticky Mucus 0 sell

# Don't pickup
Apple 0
```

## 📥 pickupitems.txt - Pickup Rules

### Simple Format
```
<item_name> <priority>
```

### Priority
- `-1`: Never pickup
- `0`: Don't auto-pickup (manual only)
- `1+`: Auto-pickup (higher = priority)

### Examples
```
# High priority
Yggdrasil Berry 15
Old Card Album 15
Card 10

# Normal items
White Herb 5
Blue Herb 5
Red Potion 3

# Ignore
Apple -1
Jellopy 0
```

### Advanced Format
```
<item_name> <priority> <conditions>
```

**Conditions:**
- `distance <n>` - Pickup within distance
- `inLockOnly 1` - Only in lockMap
- `notInTown 1` - Not in towns

## 🎯 priority.txt - Attack Priority

### Purpose
Fine-tune monster targeting.

### Format
```
<monster_name> <priority>
```

### Examples
```
# Kill first
Poring 10
Drops 10
Hornet 5

# Kill last
Metaling 1
Rocker 1

# Never target (use mon_control for ignore)
MVP Boss 0
```

## 🚫 avoid.txt - Avoidance

### Purpose
Avoid specific players/monsters.

### Format
```
<name>
```

### Examples
```
# Avoid these players
GMBot
[GM]PlayerName

# Works with partial match
GM
Bot
```

## 🛒 shop.txt - Auto-Buy/Sell

### Buy Section
```
[Shop Title From NPC]
<item_name> <quantity> [conditions]
```

**Examples:**
```
[Tool Dealer]
Fly Wing 100 inventory <= 50
Butterfly Wing 20 inventory <= 10
Arrow 1000 arrows <= 500
Red Potion 50 when {"hp" < 50%}
```

### Sell Section
```
sellAuto 1                 # In config.txt
sellAuto_npc <map> <x> <y> [sequence]
```

Items marked `sell` in items_control.txt will auto-sell.

## 🎭 macros.txt - Macro System

### Requires eventMacro Plugin

### Automacro Structure
```
automacro <name> {
    <conditions>
    call {
        <commands>
    }
}
```

### Example
```
automacro AutoHeal {
    hp < 50%
    sp > 10%
    call {
        do ss 28 10  # Heal self
    }
}

automacro BuffUp {
    whenStatusInactive Blessing
    sp > 30%
    call {
        do ss 34 10  # Cast Blessing
    }
}

automacro AutoLoot {
    itemsOnGround Yggdrasil Berry
    call {
        do take "Yggdrasil Berry"
    }
}
```

## 🗺️ Map-Specific Configs

### sys.txt - Per-Map Settings

**Location:** `control/`

**Format:**
```
<map_name> <config_key> <value>
```

**Example:**
```
prontera attackAuto 0
prt_fild08 attackAuto 2
gef_fild10 teleportAuto_search 1
```

## 🔧 Configuration Loading (`src/Settings.pm`)

### Config Parser (`src/FileParsers.pm`)

**Functions:**
- `parseConfigFile()` - Parse key-value config
- `parseItemsControl()` - Parse items_control.txt
- `parseMonControl()` - Parse mon_control.txt
- `parsePriority()` - Parse priority.txt

### Config Access
```perl
use Globals qw(%config %timeout);

# Read config value
my $attackAuto = $config{attackAuto};

# Set config value (runtime)
configModify('attackAuto', 2);

# Get timeout
my $aiTimeout = $timeout{ai}{timeout};
```

## 🎛️ Runtime Config Modification

### Console Commands
```
conf <key> <value>         # Set config
conf <key>                 # View config
conf -h                    # Help

reload config              # Reload config.txt
reload items_control
reload mon_control
```

### Via Code
```perl
use Settings;

# Modify config
configModify('attackAuto', 2);

# Reload entire config
Settings::loadAll();
```

## 📊 Config Priority

**Load Order (highest to lowest):**
1. Command line arguments
2. `config.txt`
3. `sys.txt` (map-specific overrides)
4. Runtime `conf` commands

## 🚨 Common Config Mistakes

### 1. Wrong Syntax
❌ `attackAuto = 2` (no equals sign!)
✅ `attackAuto 2`

### 2. Case Sensitivity
❌ `AttackAuto 2`
✅ `attackAuto 2`

### 3. Missing Quotes
For values with spaces:
❌ `followTarget Player Name`
✅ `followTarget "Player Name"`

### 4. Invalid Values
```
attackAuto <0-2>          # Not 3!
itemsTakeAuto <0-2>       # Not higher!
```

### 5. Conflicting Settings
```
lockMap prontera
route_randomWalk 1        # Will walk outside lockmap!
```

## 🔍 Debugging Config

### Check Current Config
```
# Console
conf                       # List all
conf attackAuto           # Check specific

# Debug mode
debug 1
```

### Config Validation
OpenKore validates on load:
- Invalid keys → Warning
- Invalid values → Warning or default

### Trace Config Loading
```perl
# In config.txt
debug 2
```

Watch console for config parse messages.

## 📝 Best Practices

1. **Comment Everything**
```
# Attack settings for Poring farming
attackAuto 2
attackDistance 1.5
```

2. **Organize by Category**
Group related settings together.

3. **Use Profiles**
Create multiple config files:
- `config_farming.txt`
- `config_leveling.txt`
Load via: `openkore.pl --config=config_farming.txt`

4. **Version Control**
Keep configs in version control (except credentials!).

5. **Test Incrementally**
Change one setting at a time to isolate issues.

## 🔗 Related Files

- `src/Settings.pm` - Config loader
- `src/FileParsers.pm` - Config parsers
- `src/Globals.pm` - Global %config hash
- `src/Commands.pm` - `conf` command implementation

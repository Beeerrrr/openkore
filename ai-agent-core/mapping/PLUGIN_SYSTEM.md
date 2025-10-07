# Plugin System Architecture

## 🔌 Plugin Overview

### Plugin Manager (`src/Plugins.pm`)

**Purpose:** Load, manage, and coordinate plugins

**Key Functions:**
- `Plugins::loadAll()` - Load all plugins
- `Plugins::unloadAll()` - Unload plugins
- `Plugins::reload()` - Reload specific plugin
- `Plugins::callHook()` - Trigger event hooks

### Plugin Directory Structure
```
plugins/
├── myPlugin/
│   ├── myPlugin.pl          # Main plugin file
│   ├── config.txt           # Plugin config
│   └── modules/             # Plugin modules
│       └── MyModule.pm
└── anotherPlugin.pl         # Single-file plugin
```

## 🎯 Plugin Lifecycle

### 1. Loading Phase
```perl
# In myPlugin.pl
package myPlugin;

use strict;
use Plugins;
use Globals;

Plugins::register('myPlugin', 'Description', \&onUnload);

sub onUnload {
    # Cleanup code
}
```

### 2. Hook Registration
```perl
my $hooks = Plugins::addHooks(
    ['packet/map_loaded', \&onMapLoaded],
    ['AI_pre', \&onAI_pre],
    ['in_game', \&onInGame]
);
```

### 3. Event Handling
```perl
sub onMapLoaded {
    my (undef, $args) = @_;
    my $map = $args->{map};
    # Handle map loaded
}
```

### 4. Unloading Phase
```perl
sub onUnload {
    Plugins::delHooks($hooks);
    # Additional cleanup
}
```

## 🪝 Hook System (Bus Events)

### Core Hooks (`src/Bus/`)

**Timing Hooks:**
- `mainLoop_pre` - Before main loop iteration
- `mainLoop_post` - After main loop iteration
- `AI_pre` - Before AI processing
- `AI_post` - After AI processing

**Network Hooks:**
- `packet/recv` - Any packet received
- `packet/sent` - Any packet sent
- `packet/[packetName]` - Specific packet
- `Network::connectTo` - Server connection

**Game State Hooks:**
- `in_game` - Entered game world
- `map_loaded` - Map change complete
- `target_changed` - Combat target changed
- `route_dest` - Routing destination set

**Combat Hooks:**
- `attack_start` - Started attacking
- `attack_end` - Stopped attacking
- `is_casting` - Casting skill
- `packet/skill_use` - Skill used

**Actor Hooks:**
- `actor_new` - New actor spawned
- `actor_died` - Actor died
- `player_disappeared` - Player vanished
- `monster_disappeared` - Monster vanished

**Item Hooks:**
- `item_appeared` - Item on ground
- `item_gathered` - Picked up item
- `inventory_ready` - Inventory loaded
- `deal_request` - Trade request

**Chat Hooks:**
- `packet/chat_message` - Public chat
- `packet/private_message` - PM received
- `packet/party_chat` - Party chat
- `packet/guild_chat` - Guild chat

### Hook Data Structure
```perl
sub myHook {
    my (undef, $args) = @_;
    # $args is hashref with event data
    # $args->{return} - Set to modify behavior
}
```

### Hook Priority
Hooks execute in registration order. Use:
```perl
$args->{return} = 1;  # Prevent further hook processing
```

## 🛠️ Plugin Development

### Basic Plugin Template
```perl
package MyPlugin;

use strict;
use Plugins;
use Globals qw($char $net $messageSender);
use Log qw(message warning error);
use Utils;

Plugins::register('MyPlugin', 'My plugin description', \&unload);

my $hooks;

sub unload {
    Plugins::delHooks($hooks);
}

$hooks = Plugins::addHooks(
    ['in_game', \&onInGame],
    ['AI_pre', \&onAI]
);

sub onInGame {
    message "[MyPlugin] Entered game!\n";
}

sub onAI {
    # Custom AI logic
}

1;  # End of plugin
```

### Accessing Game Data
```perl
use Globals qw(
    $char              # Your character
    $net               # Network object
    $messageSender     # Send packets
    $field             # Current map
    @monstersID        # Monster list
    @playersID         # Player list
    $monstersList      # Monster ActorList
    $playersList       # Player ActorList
    %config            # Configuration
    %timeout           # Timeouts
);

# Example usage
my $hp = $char->{hp};
my $sp = $char->{sp};
my $map = $field->baseName();

# Get monster by ID
my $monster = $monstersList->getByID($monstersID[0]);
if ($monster) {
    my $name = $monster->{name};
    my $hp = $monster->{hp};
}
```

### Sending Commands
```perl
use Commands;

Commands::run('c Hello world');      # Chat
Commands::run('ml');                  # Monster list
Commands::run('e OK');                # Emotion
```

### Sending Packets
```perl
$messageSender->sendMove($x, $y);
$messageSender->sendAttack($monsterID);
$messageSender->sendSkillUse($skillID, $level, $targetID);
$messageSender->sendChat('Hello');
```

## 📦 Major Plugins

### 1. eventMacro (`plugins/eventMacro/`)

**Purpose:** Advanced automation via macros

**Features:**
- Conditional logic
- Variable system
- Complex sequences
- Event-triggered actions

**Files:**
- `eventMacro.pl` - Main plugin
- `eventMacro/Automacro.pm` - Automacro engine
- `eventMacro/Condition/*.pm` - Condition checkers
- `eventMacro/Runner/*.pm` - Command runners

**Usage:**
```
# In control/macros.txt
automacro AutoHeal {
    hp < 50%
    call {
        do is 506  # Use healing item
    }
}
```

### 2. breakTime (`plugins/breakTime/`)

**Purpose:** Scheduled breaks to avoid detection

**Features:**
- Random break scheduling
- Configurable break duration
- Auto-logout

### 3. customCaption (`plugins/customCaption/`)

**Purpose:** Customize window title

**Features:**
- Dynamic title updates
- Show character stats
- Show location

### 4. alertSound (`plugins/alertSound/`)

**Purpose:** Audio alerts for events

**Features:**
- PM alerts
- Death alerts
- Guild message alerts

## 🔧 Advanced Plugin Techniques

### Creating Custom AI States
```perl
sub onAI {
    return unless AI::is('myCustomState');

    # Custom AI logic
    # ...

    # Complete state
    AI::dequeue();
}

# Trigger custom state elsewhere
AI::queue('myCustomState');
```

### Modifying Network Packets
```perl
sub onPacketSent {
    my (undef, $args) = @_;
    # Modify $args->{data} before sending
    # Set $args->{return} = 1 to cancel
}

$hooks = Plugins::addHooks(
    ['Network::packet_sent', \&onPacketSent]
);
```

### Adding Custom Commands
```perl
use Commands;

Commands::register(
    ['mycommand', 'My custom command', \&cmdMyCommand]
);

sub cmdMyCommand {
    my (undef, $args) = @_;
    message "Command executed: $args\n";
}

# Usage in console: mycommand arg1 arg2
```

### Timers and Delays
```perl
use Time::HiRes qw(time);

my $lastAction = 0;
my $delay = 5;  # 5 seconds

sub onAI {
    return if time - $lastAction < $delay;

    # Do action
    $lastAction = time;
}
```

## 🚨 Plugin Best Practices

### 1. Proper Hook Management
✅ **DO:**
```perl
my $hooks;
sub unload { Plugins::delHooks($hooks); }
$hooks = Plugins::addHooks(...);
```

❌ **DON'T:**
```perl
Plugins::addHooks(...);  # Never stores $hooks!
```

### 2. Error Handling
```perl
use Log qw(error);

sub myFunction {
    eval {
        # Risky code
    };
    if ($@) {
        error "[MyPlugin] Error: $@\n";
    }
}
```

### 3. Configuration Files
```perl
use FileParsers qw(parseConfigFile);

my %pluginConfig;
parseConfigFile(
    "plugins/myPlugin/config.txt",
    \%pluginConfig
);

my $setting = $pluginConfig{mySetting};
```

### 4. Performance Considerations
- Avoid heavy processing in `AI_pre`/`mainLoop_pre`
- Use timeouts for periodic checks
- Cache expensive calculations
- Unregister unused hooks

### 5. Compatibility
- Test with different server types
- Check OpenKore version compatibility
- Document dependencies

## 📝 Plugin Debugging

### Enable Debug Output
```perl
use Log qw(debug);
debug "[MyPlugin] Debug message\n", "myPlugin";
```

**In config.txt:**
```
debug 2
debugPacket_include myPlugin
```

### Common Issues

**Plugin not loading:**
- Check plugin directory/filename
- Check `Plugins::register()` call
- Check for syntax errors

**Hooks not firing:**
- Verify hook name spelling
- Check hook timing (may fire before plugin loads)
- Use `debugPacket_include` to trace events

**Memory leaks:**
- Always unregister hooks in `unload()`
- Clear global variables
- Remove timers

## 🔗 Plugin Resources

**Key Files:**
- `src/Plugins.pm` - Plugin manager
- `src/Bus/` - Event system
- `src/Commands.pm` - Command system
- `plugins/` - Plugin directory

**Documentation:**
- `src/doc/` - OpenKore docs
- Plugin examples in `plugins/`
- Hook list: Run `openkore.pl` with debug mode

## 🎓 Learning from Existing Plugins

**Recommended study order:**
1. `alertSound.pl` - Simple plugin basics
2. `customCaption.pl` - Hook usage
3. `breakTime/` - Multi-file plugin
4. `eventMacro/` - Complex plugin architecture

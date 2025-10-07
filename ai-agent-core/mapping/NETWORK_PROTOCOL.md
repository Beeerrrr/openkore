# Network Protocol & Packet Handling

## 🌐 Network Architecture

### Main Network Module (`src/Network.pm`)

**Purpose:** Base network abstraction layer

**Key Responsibilities:**
- Connection management
- Server selection
- Protocol version detection
- Packet routing

### Network Flow
```
Server ←→ Network.pm ←→ MessageTokenizer ←→ Receive.pm
                                                ↓
                                           Packet handlers
                                                ↓
                                           Game state updates
```

## 📦 Packet System

### 1. Receiving Packets (`src/Network/Receive.pm`)

**Structure:**
```perl
# Packet handler registration
$packetHandlers{ABCD} = \&handler_function;

# Handler function
sub handler_function {
    my ($self, $args) = @_;
    # Process packet
}
```

**Common Packet Handlers:**
- `account_id` - Login response
- `server_list` - Available servers
- `map_loaded` - Map change complete
- `actor_exists` - Entity spawn
- `actor_display` - Entity update
- `actor_died` - Death notification
- `chat_message` - Chat received
- `inventory_items` - Item list
- `stats_info` - Character stats

### 2. Sending Packets (`src/Network/Send.pm`)

**Structure:**
```perl
# Send packet
$messageSender->sendPacketName($args);

# Example
$messageSender->sendAttack($monsterID);
$messageSender->sendMove($x, $y);
$messageSender->sendSit();
```

**Common Send Functions:**
- `sendAttack()` - Attack target
- `sendMove()` - Move to coordinates
- `sendSkillUse()` - Use skill
- `sendTake()` - Pick up item
- `sendDrop()` - Drop item
- `sendChat()` - Send chat message
- `sendGetPlayerInfo()` - Request player info

### 3. Message Tokenizer (`src/Network/MessageTokenizer.pm`)

**Purpose:** Parse raw packet stream into individual packets

**Functions:**
- Buffer management
- Packet boundary detection
- Length calculation
- Data extraction

## 🔌 Server Types & Versions

### Server Directories (`src/Network/Receive/`)

Different RO server types require different packet handlers:

- `kRO/` - Korean servers
- `iRO/` - International servers
- `bRO/` - Brazilian servers
- `twRO/` - Taiwan servers
- `ServerType0/`, `ServerType1/`, etc. - Generic types

### Protocol Selection

**In `tables/servers.txt`:**
```
[Server Name]
ip 127.0.0.1
port 6900
master_version 1
version 1
serverType kRO_RagexeRE_2020_09_02
```

**Key Fields:**
- `master_version` - Login server version
- `version` - Character server version
- `serverType` - Packet handler to use

## 📋 Packet Structure

### Basic Packet Format
```
[PacketID] [Length] [Data...]
  2 bytes   2 bytes   Variable
```

### Packet Types

**1. Fixed Length**
```perl
# Example: Sit/Stand (0x0089)
pack('v', 0x0089) . pack('C', $action)
```

**2. Variable Length**
```perl
# Length included in packet
pack('v v', $packetID, $length) . $data
```

## 🎯 Critical Packets

### Connection Packets
- `0x0064` - Login request
- `0x0065` - Server list
- `0x0066` - Character select
- `0x0067` - Character creation
- `0x0073` - Map server connection

### Movement Packets
- `0x0085` - Move to coordinates
- `0x0089` - Sit/stand
- `0x00BF` - Emotion
- `0x0437` - Walk to location

### Combat Packets
- `0x0089` - Attack
- `0x0113` - Skill use (location)
- `0x0116` - Skill use (target)
- `0x043F` - Combo skill

### Item Packets
- `0x00F5` - Item use
- `0x007E` - Item move
- `0x00F3` - Cart item move
- `0x0193` - Identify item

### Chat Packets
- `0x008C` - Public chat
- `0x00F3` - Private message
- `0x017E` - Guild message
- `0x0108` - Party message

### NPC Packets
- `0x0090` - Talk to NPC
- `0x00B8` - NPC next
- `0x00B9` - NPC close
- `0x00BF` - NPC response select
- `0x01D3` - NPC input text

## 🔧 Packet Debugging

### Enable Packet Debug
**config.txt:**
```
debug 2
debugPacket_sent 1
debugPacket_received 1
```

### Packet Dumping
**logs/packets.txt:**
```
[Recv] 008A [length]
[Send] 0089 [length]
```

### Network Capture Tools
- Wireshark with RO dissector
- `packetdump.pl` utility
- OpenKore packet logger

## 🚨 Common Network Issues

### 1. Wrong Server Type
**Symptom:** Can't login, disconnect after character select
**Fix:** Adjust `serverType` in `servers.txt`

### 2. Packet Encryption
**Symptom:** Connection drops, no packet handlers triggered
**Fix:** Check if server uses packet obfuscation

### 3. Version Mismatch
**Symptom:** Some features don't work
**Fix:** Update `master_version` / `version` fields

### 4. Packet Length Errors
**Symptom:** "Unknown packet" errors, crashes
**Fix:** Update `recvpackets.txt` for server

## 📊 Network Performance

### Optimization
- Reduce unnecessary packet sends
- Batch chat messages
- Optimize movement (reduce waypoints)
- Use client-side calculations when possible

### Rate Limiting
**config.txt:**
```
teleportAuto_lostTarget_timeout 2
attackCanSnipe_timeout 2
```

Prevents packet spam that can trigger server anti-bot.

## 🔗 Integration Points

### Event System
Network packets trigger Bus events:
```perl
Plugins::callHook('packet/map_changed', {
    map => $map
});
```

### Actor Updates
Packets update global actor lists:
- `@monstersID` - Monsters
- `@playersID` - Players
- `@npcsID` - NPCs
- `@itemsID` - Ground items

### Task System
Network events can:
- Create tasks (NPC interaction)
- Complete tasks (route finished)
- Cancel tasks (target died)

## 🛠️ Extending Network Layer

### Adding Custom Packet Handler

1. **Identify packet ID** (from server packets)
2. **Add to Receive.pm:**
```perl
sub my_custom_packet {
    my ($self, $args) = @_;
    # Parse packet data
    # Update game state
    # Trigger events
}

$packetHandlers{ABCD} = \&my_custom_packet;
```

3. **Add packet structure** to `recvpackets.txt`:
```
ABCD 10 custom_packet
```

### Adding Custom Send Function

**In Send.pm:**
```perl
sub sendCustomPacket {
    my ($self, $arg1, $arg2) = @_;
    my $msg = pack('v v C', 0xABCD, 5, $arg1);
    $self->sendToServer($msg);
}
```

## 📝 Important Files

- `src/Network/Receive.pm` - Packet receivers (~5000+ lines)
- `src/Network/Send.pm` - Packet senders (~3000+ lines)
- `tables/recvpackets.txt` - Packet ID → Name mapping
- `tables/servers.txt` - Server configurations
- `src/Network/MessageTokenizer.pm` - Packet parser

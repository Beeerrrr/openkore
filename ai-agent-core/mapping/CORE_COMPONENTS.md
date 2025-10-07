# OpenKore Core Components Map

## 🎯 Project Overview
**Name:** OpenKore
**Type:** Ragnarok Online Bot Framework
**Language:** Perl
**Architecture:** Plugin-based event-driven system

## 📦 Core Modules

### 1. AI System (`src/AI.pm`, `src/AI/`)
**Purpose:** Core AI decision-making engine
**Key Components:**
- AI queue management
- State machine implementation
- Decision tree logic
- Task prioritization

**Key Files:**
- `src/AI.pm` - Main AI controller
- `src/AI/CoreLogic.pm` - Core AI logic
- `src/AI/Attack.pm` - Combat AI
- `src/AI/Slave.pm` - Slave/homunculus AI
- `src/AI/SlaveManager.pm` - Slave management

### 2. Network Layer (`src/Network/`, `src/Network.pm`)
**Purpose:** Handles all RO server communication
**Key Components:**
- Packet handling
- Protocol implementations
- Server connection management

**Key Files:**
- `src/Network.pm` - Network base
- `src/Network/Receive.pm` - Packet receiving
- `src/Network/Send.pm` - Packet sending
- `src/Network/MessageTokenizer.pm` - Packet parsing

### 3. Actor System (`src/Actor.pm`, `src/Actor/`)
**Purpose:** Represents game entities (players, monsters, NPCs, items)
**Key Components:**
- Player state management
- Monster tracking
- NPC interaction
- Item management

**Key Files:**
- `src/Actor.pm` - Base actor class
- `src/Actor/Player.pm` - Player actors
- `src/Actor/Monster.pm` - Monster actors
- `src/Actor/NPC.pm` - NPC actors
- `src/Actor/Item.pm` - Ground items
- `src/ActorList.pm` - Actor collection management

### 4. Task System (`src/Task.pm`, `src/Task/`, `src/TaskManager.pm`)
**Purpose:** Asynchronous task execution
**Key Components:**
- Task queue
- Task dependencies
- Task state management

**Key Files:**
- `src/Task.pm` - Base task class
- `src/TaskManager.pm` - Task queue manager
- `src/Task/MapRoute.pm` - Pathfinding tasks
- `src/Task/TalkNPC.pm` - NPC interaction tasks

### 5. Commands (`src/Commands.pm`)
**Purpose:** Console command processing (291KB - massive file!)
**Functions:** All user-facing bot commands

### 6. Utils & Helpers
**Purpose:** Utility functions and helpers
**Key Files:**
- `src/Utils.pm` - General utilities (50KB)
- `src/Misc.pm` - Miscellaneous functions (177KB)
- `src/Globals.pm` - Global variables
- `src/Settings.pm` - Configuration management
- `src/FileParsers.pm` - Config file parsing

### 7. Field/Map System (`src/Field.pm`)
**Purpose:** Map handling and pathfinding
**Key Components:**
- Field data structures
- Collision detection
- Pathfinding (A*)

### 8. Plugin System (`src/Plugins.pm`)
**Purpose:** Plugin loading and management
**Location:** `plugins/` directory

### 9. Interface System (`src/Interface.pm`, `src/Interface/`)
**Purpose:** User interface abstraction
**Implementations:**
- Console interface
- Wx (GUI) interface
- Remote interface

### 10. Inventory & Items (`src/InventoryList.pm`, `src/InventoryList/`)
**Purpose:** Inventory management
**Functions:** Item tracking, storage, equipment

## 🔌 Plugin Architecture

**Location:** `plugins/`

**Major Plugins:**
- `eventMacro/` - Advanced macro system
- `breakTime/` - Break scheduling
- `customCaption/` - Window customization
- `alertSound/` - Alert notifications
- `AdventureAgency/` - Adventure features

## 🎮 Main Entry Point
**File:** `openkore.pl`
**Purpose:** Application bootstrap and main loop

## 📊 Data Flow
```
openkore.pl
    ↓
AI.pm (main loop)
    ↓
Network.pm ← → Server
    ↓
Actor updates
    ↓
Task execution
    ↓
Commands processing
```

## 🗂️ Directory Structure
```
openkore/
├── src/           # Core Perl modules
├── plugins/       # Plugin system
├── fields/        # Map data
├── tables/        # Game data tables
└── control/       # User configuration
```

## 🔑 Critical Files (by size/importance)
1. `src/Commands.pm` (291KB) - All bot commands
2. `src/Misc.pm` (177KB) - Miscellaneous utilities
3. `src/Utils.pm` (50KB) - Core utilities
4. `src/Field.pm` (25KB) - Map handling
5. `src/AI.pm` (24KB) - AI controller

## 📝 Notes
- Heavily event-driven architecture
- Plugin system allows easy extensibility
- Network protocol varies by RO server version
- AI runs in synchronous loop with task queue

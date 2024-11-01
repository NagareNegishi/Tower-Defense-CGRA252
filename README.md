# Tower Defense
# CGRA252

# Note on Repository Versions
## Release Version
- Release: "Goblins' Fury: Fortress Fight - First Release"
- Tag: v1.0.1
- Contains:
 - Working exported game files in main/export/windows
 - Windows version
 - Web version
 - Core functionality

This release version is recommended for game submission review.

## Main Branch
Please also refer to the main branch for:
- Individual project reports
- Group demonstration video
- Additional features that may be added after release
 - Currently added:
   - 2 additional towers implemented
   - Difficulty rebalanced to accommodate new towers
   - 2 new boss-type enemies
   - Styled button improvements
- Latest documentation updates

## Note on Smart Commits
Initial phase:
- Issue #3 was pre-allocated for setup planning
- Team members used individual issue numbers for commits

After project reorganization:
- Standardized all development commits to issue #17

# The title of the game

Goblins’ Fury: Fortress Fight

# Your group name

Team 6

# Names and roles of the team members
🐻 Eric Liu

🐺 Lawrence Huangfu

🐱 Bruno Helbick

🐶 Nagare Negishi  ( smart commits on: #11, #17 )

🐰 Brock Clarke (Smart commits on #12 #19 #21)

🦉 Angus Ng

# Link to video (onedrive/vimeo/youtube/googledrive other video service) showing the design of the game ( approx. 2-4 mins )

- https://drive.google.com/file/d/1G-85lo--mbkCuej0Jl6LQ6dVApytIs8x/view?usp=drive_link

# Link to video Part 2 (onedrive/vimeo/youtube/googledrive other video service) showing the design of the game 

- https://drive.google.com/file/d/1RbY_nErklaLgeHszo1-wWQy5fIIjs2zN/view?usp=drive_link

# Link to video Part 3 (onedrive/vimeo/youtube/googledrive other video service) showing the design of the game 

- https://drive.google.com/file/d/1troT2-3EQpNJ_C6eF5hoqMbaTH-ARTEz/view?usp=drive_link

# Game Description

### What is the style of the game, what are similar games

Key Style Elements:
- Top-down 2D perspective with pixel art aesthetics
- Strategic tower placement and resource management
- Wave-based enemy progression system
- Focus on defensive gameplay and tactical decision-making

Similar Games:
- Bloons TD: Similar in its core tower defense mechanics

### What is the main game mechanic

**Pre-round Setup & Wave Management**:
- Players strategically place towers on the map before and during waves
- New wave can be started manually via "Next Wave" button
- Tower management continues during wave progression
- Pause function available (tower placement disabled during pause)

**Tower System & Mechanics**:
- Multiple tower types:
  - Arrow Tower: Single-target damage dealer
  - AOE Tower: Area-of-effect slow effect
- Tower upgrades available:
  - Attack Speed: Reduces time between attacks
  - Attack Range: Increases tower's targeting range
- Strategic placement crucial for optimal defense

**Enemy Wave System**:
- Enemies follow predetermined paths to reach player's base
- Enemy variants with different attributes:
  - Speed variations
  - Different health points
  - Various damage values to base
- Each enemy that reaches the base deals damage
- Wave progression increases difficulty

**Resource Management**:
- Earn gold by defeating enemies
- Resources used for:
  - Purchasing new towers
  - Upgrading existing towers
- Strategic balance between:
  - Immediate defense needs
  - Saving for tower upgrades

**Base Defense System**:
- Players must protect their base at the end of enemy paths
- Base health decreases when enemies reach it
- Game over condition:
  - Base health reaches zero
  - Victory by surviving all waves

### A list of the challenging engine technology currently used

In developing this tower defense game, we encountered and overcame several technical challenges using Godot's features:

**Architecture and Design Patterns**:
- Implemented extensible class hierarchy for entities:
  - Created abstract super classes for towers and enemies
  - Designed flexible system for adding new tower/enemy types
  - Separated responsibilities into focused components

**Signal System and Communication**:
- Extensive use of Godot's signal system:
  - Tower-to-enemy detection and targeting
  - Resource management and UI updates
  - Wave progression and game state management
  - Error handling and validation

**Game Systems Implementation**:
- Dynamic Difficulty System:
  - Implemented algorithm considering:
    - Number of towers built
    - Enemy defeat rate
    - Resource efficiency
  - Balanced wave generation using controlled randomness
  - Min/max limits for maintainable challenge

**Input Management**:
- Centralized input handling system:
  - Mouse tracking and UI interaction
  - Tower placement validation
  - Menu and game state controls
  - Multi-state input processing

**Path System and Enemy Navigation**:
- Implemented pathfinding system:
  - Predefined path following
  - Enemy movement coordination
  - Collision detection and handling

**Scene Management**:
- Organized complex scene hierarchies
- Implemented proper node communication
- Handled scene transitions and state persistence

## A list of the challenging engine technology that will be tested for the rest of the development.

Future Development Challenges and Technical Improvements

**Entity System Enhancement**:
- Expand the current superclass system:
  - Add more diverse enemy types with unique behaviors
  - Implement specialized tower types with different attack patterns
  - Challenge: Maintaining balance while increasing complexity

**Game Balance and Analytics**:
- Improve the difficulty adjustment system:
  - Implement data collection for player performance metrics
  - Create visualization tools for balance testing
  - Develop more sophisticated wave generation algorithms
  - Challenge: Mathematical modeling of game balance

**Performance Optimization**:
- Optimize for larger numbers of entities:
  - Improve collision detection efficiency
  - Challenge: Maintaining smooth performance with complex interactions

**UI/UX Improvements**:
- Enhanced tower interaction system:
  - Preview tower range and attack patterns
  - Improved upgrade interface
  - Better visual feedback for player actions
  - Challenge: Creating intuitive yet informative displays

## A list of features that have been implemented in the prototype:

Prototype:

- Basic Level Management: Temp_LevelManager implements a basic structure for managing game levels and waves.
- Prototype tower although interaction with enemy was poor
- Many different enemy without super type
- HUD bare minimum to show coin or life
- Spawner to spawn enemy and it follows path

Group final project:

- Complete wave-based level management system
- Two functional tower types with upgrade capabilities
- Multiple enemy types with path following behavior
- HUD system with resource and health display
- Wave control system with manual progression
- Working economy system (gold earning and spending)

## Controls: how to interact with the ~~prototype~~ Group final project

**Basic Controls**:
- All interactions use mouse and left-click

**Wave Management**:
- Click "Next Wave" button to start new wave
- Waves progress automatically once started

**Tower Management**:
1. Tower Placement:
   - Click tower purchase button
   - Tower preview follows mouse cursor
   - Preview shows green for valid placement, red for invalid
   - Left-click to place tower in valid location

2. Tower Interaction:
   - Left-click existing tower to select
   - When selected, three options appear:
     - Two upgrade buttons (attack speed/range)
     - One sell button (returns partial gold)
   - Click upgrade/sell buttons to execute action

**Game Settings**:
- Press pause button to open settings
- Settings menu features:
  - Volume control slider
  - Unpause button to return to game
  - Game continues only after unpausing

**Additional Notes**:
- Towers attack automatically when in range
- Game can be paused at any time
- Tower placement and upgrades available during waves

## List of Assets used/templates used:

https://free-game-assets.itch.io/free-field-enemies-pixel-art-for-tower-defense

https://free-game-assets.itch.io/free-fields-tileset-pixel-art-for-tower-defense

https://free-game-assets.itch.io/free-archer-towers-pixel-art-for-tower-defense

https://free-game-assets.itch.io/free-magic-and-traps-top-down-pixel-art-asset


### Task Division

- Stage: Responsible for the game environment and coordinating tower and enemy positions/ path.
- Tower: Develops the tower system, including different types, upgrades, and attack mechanics.
- Enemy: Creates the enemy system, including different types, movement, and interaction with towers.
- HUD: Designs and implements all UI elements and information display.
- InputController: Manages all user interactions and game controls.
- LevelManager: Handles level progression, wave management, and difficulty scaling.

Each task was initially assigned to:

- Stage: Jinhao Huangfu ?
- Tower: Bruno Helbick ?
- Enemy: Brock Clarke
- HUD: Angus Ng
- InputController: Eric Liu ?
- LevelManager: Nagare Negishi

Each task was implemented by:

- Stage: Brock Clarke(in progress), Nagare Negishi(script)
- Tower: Bruno Helbick(in progress) ,Nagare Negishi(refactor/super class/new type)
- Enemy: Brock Clarke
- HUD: HUD.tscn Brock Clarke(in progress), HUD.gd Nagare Negishi, Angus Ng
- InputController: Nagare Negishi
- LevelManager: Nagare Negishi
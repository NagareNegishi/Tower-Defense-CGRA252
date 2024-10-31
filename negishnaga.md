# Repository Links

## Main Repository
https://gitlab.ecs.vuw.ac.nz/course-work/cgra252/2024/project/team6/tower-defense

## Release Version
- Release: "Goblins' Fury: Fortress Fight - First Release"
- Tag: v1.0.1
- URL: https://gitlab.ecs.vuw.ac.nz/course-work/cgra252/2024/project/team6/tower-defense/-/releases/v1.0.1


# Individual Project Report

## Header Information
- **Name**: Nagare Negishi

- **Username**:
    - negishnaga
    - Initially : negimakushi
    - ( smart commits on: #11, #17 )

- **Project Role**: Lead Developer & System Architect
    - Initially assigned to LevelManager Developer
    - Extended to: Full-system development and integration
      - Stage and InputController systems
      - Enemy/Tower systems enhancement
      - HUD implementation and improvements

- **Animal Role**: 🐶 Puppy

## Group Contribution
### Your Contribution
- Project Architecture

    - Created initial task division and component interaction design
    - Established system architecture that was adopted by the team

- Project Management

    - Documentation lead (90%+ of project documentation)
    - Git workflow management:
      - Issue tracking and milestone planning
      - Label and tag organization
      - Issue board management and release branch creation
    - Project restructuring to match team capacity

- Core Development

    - LevelManager: Implemented complete game progression system
    - Stage: Developed core stage functionality and path system
    - InputController: Rebuilt tower placement and upgrade system
    - Tower System: Refactored and enhanced tower mechanics
    - Enemy System: Improved existing code with better class structure
    - HUD: Implemented game interface functionality

### Communication Role

#### Initial Role: Enthusiastic Supporter (🐶 Puppy)
- Aimed to support challenging and interesting ideas
- Advocated for more ambitious approaches:
  - Supported initial proposal to use Unreal Engine for 3D possibilities
  - Encouraged exploring beyond basic TD Balloon inspiration
  - Backed suggestion for multiple enemy path system

#### Role Evolution
As project needs emerged, gradually adopted additional responsibilities:
  - 🦉 Owl: Took responsibility to keep project on track for deadlines
  - Due to limited team participation, had to adopt leadership roles:
    - 🐻 Bear: Had to take leadership role as no one was leading the team
    - 🐺 Wolf: Managed project progress when no management was present
  - 🐰 Rabbit: Acted as facilitator, communicating with course coordinator for guidance

#### Challenge Management
- **Engine Selection**
  - Respected majority decision for Godot despite personal interest in Unreal
  - Supported team members' asset suggestions (found them good choices)

#### Team Coordination
- **Participation Management**
  - Maintained positive support despite limited participation
  - Sought course coordinator guidance when needed
  - Reorganized project structure to accommodate active participants

- **Leadership Approach**
  - Kept supportive attitude throughout project
  - Balanced multiple communication roles effectively
  - Focused on project progress while maintaining team morale


### Group Dynamics

#### Communication Challenges
- Major challenge: Unclear team participation status
  - No authority to confirm member status
  - No means to officially change group composition
  - Non-responding members remained officially in project

#### Communication Platforms
- **Initial Setup**
  - Discord agreed as primary communication platform
  - Attempted to establish regular meetings
    - First two meetings conducted successfully
    - Third meeting never materialized due to declining participation

- **Platform Evolution**
  - Discord: Proved effective for active participants
  - Email: Used following coordinator's advice
    - Kept logs as suggested
    - Continued with Discord due to lack of email responses

#### Project Adaptation
- **Team Reorganization**
  - Announced changes through both email and Discord
  - Adjusted project scope based on active participation
  - Created new task management system
    - Listed remaining tasks in issues
    - Implemented task claiming system to prevent conflicts

#### Effective Collaboration
- Active members maintained strong communication
  - Used Discord for real-time coordination
  - Effectively divided remaining tasks
  - Adjusted project goals based on:
    - Available resources
    - Realistic schedule
    - Active member capacity

## Project Structure

To illustrate the game's architecture and component relationships, I created this structural diagram:

![Game Structure Diagram](/images/documentation/game_structure.png)

Key components and their relationships:
- **Core Systems**:
  - Auto Load components (Global, BackGroundMusic, SceneManager)
  - Main Menu → Game flow → Victory/Game Over states

- **Game Components**:
  - Stage System: Manages Path, Platform, and Tower placement
  - Input System: Handles user interaction through InputManager and UpgradePopup
  - Tower System: Implements Arrow and Tower2 (with Thunderbolt) mechanics
  - Enemy System: Controls various enemy types through EnemyBase
  - Level Management: Coordinates Wave generation and difficulty through StrengthEstimator

## Code Discussion
### Project Contributions

**Level Management System** (\Scripts\level_manager)

- `game_stats.gd` [All]
    - GameStats manages the game statistics such as score, life, and resources

- `wave.gd` [All]
    - generates array of enemies and sends them based on difficulty of the game

- `strength_estimator.gd` [All]
    - StrengthEstimator estimates the player's strength and the difficulty of the level.
    - The player's strength is estimated based on the number of towers built, the defeat rate, and the resource efficiency.

- `level_manager.gd` [All]
    - LevelManager generates waves based on difficulty from StrengthEstimator
    - Manages game progression, game over, next level, victory

- `Game.gd` [All]
    - Root of the game, connects all managing level components of game

- All files in `\Scenes\Level_Manager` and `\Scripts\level_manager\temp` [All]
    - code used for prototype are in temp folder, not used for final submission but necessary for the prototype

**Stage Management System** (\Scripts\stage)

- `platform.gd` [Most]
    - Platform to place towers.
    - Took over existing, but almost empty script. Checks the valid location.

- `EnemyPath.gd` [Half]
    - Path where enemies follow.
    - This script itself is entirely made by me, however used some existing code in the process to make it.

- `Stage.gd` [All]
    - Manages tower placement.
    - Contains path and array of platform, array of enemies.

- `Stage.tscn` [Some]
    - Scene for stage, used platform and path meeting with existing map images.

**Input Management System** (\Scripts\InputManager)

- `InputManager.gd` [All]
   - Manages user input from mouse to trigger tower placement, upgrade, sell

- `TowerManager.gd` [All]
   - Supports InputManager, contains tower scenes and provides information

- `UpgradePopup.gd` [All]
   - Shows and manages UI for tower upgrade, sell

- All files in `\Scenes\InputManager` [All]
   - Scenes for corresponding scripts

**Tower System** (\Scripts\Tower) (\Scripts) (\Scenes\Towers)

- `tower.gd` [Half]
   - Base class of tower that detects and attacks enemies, with upgrade capability
   - Code existed with buggy firing system and auto-leveling when taken over
   - Made improvements:
     - Added class name and made it extendable
     - Fixed firing system to aim at most advanced enemy and timing
     - Added upgrade system with 2 options and selling function

- `tower1Arrow.gd` [Some]
   - Homing projectile used by tower to attack enemy
   - Code existed but had inefficient condition checks due to lack of enemy super class
   - Refactored code and made it extendable

- `tower2.gd` [All]
   - Tower with AoE ability fires Thunderbolt
   - Simple implementation as subclass after making tower extendable

- `Thunderbolt.gd` [All]
   - AoE used by tower2
   - Attacks enemies up to 4 times and temporarily slows them down

- `tower1.tscn` [Touched]
   - Scene for tower.gd
   - Modified to show attack range and selected status

- `tower2.tscn` [All]
   - Scene for tower2.gd
   - Duplicated and modified tower1.tscn with different animation

- `thunderbolt.tscn` [All]
   - Scene for Thunderbolt.gd

**Enemy System** (\Scripts\Enemies)

- `EnemyBase.gd` [Some]
   - Enemy types Slime, Bee, Wolf and Goblin already existed with same behavior
   - Made improvements:
     - Refactored existing code for easy management and future extension
     - Added slow down function

**HUD System** (\Scripts\Menu) (\Scripts)

- `HUD.gd` [Most]
   - Implemented button set up and actions triggered by them

- `EndMenu.gd` [All]
   - Script for game over, victory scene
   - Refactored `MainMenu.gd`, duplicated and modified

- `SceneManager.gd` [All]
   - Manages scene transition, this script is autoloaded

- All files in `\Scenes\Menu` [All]
   - Scenes for corresponding scripts


## Video Discussion

https://myvuwac-my.sharepoint.com/:v:/g/personal/negishnaga_myvuw_ac_nz/EaXLwxTua-hAjvZJZ9B6llcBW9BrurcfPpsRn4GHKE_H6A

## Most Interesting Code

The most interesting part of my code is the strength estimation system in `strength_estimator.gd`. This system dynamically adjusts game difficulty by analyzing three key factors:
1. Tower strength (how many towers built)
2. Defeat rate (enemy elimination efficiency)
3. Resource efficiency (gold usage effectiveness)

The system uses these factors and success rate to calculate appropriate difficulty levels
This implementation is particularly interesting because it creates a dynamic difficulty system that responds to player skill and strategy, rather than using a fixed difficulty curve.

**Link to code**:
https://gitlab.ecs.vuw.ac.nz/course-work/cgra252/2024/project/team6/tower-defense/-/blob/main/Tower-Defense-Game/Scripts/level_manager/strength_estimator.gd#L15-48


## Code I'm Most Proud Of

I am most proud of the Input Management system, particularly the integration between `InputManager.gd` and `UpgradePopup.gd`.

The previous implementation had several issues:
- Drag and drop system caused frequent positioning errors
- Right-click for upgrades was unintuitive
- Upgrade buttons attached directly to towers
- Multiple interaction methods led to user confusion

My reimplementation solves these issues while making the game more intuitive:
- Preview-based placement shows valid positions before placement
- Unified left-click system for all interactions
- Centralized popup system for upgrades instead of attached buttons
- Clear visual feedback (green/red preview) for placement validity

**Code Quality Improvements**:
- Clear separation of responsibilities between input handling and UI
- Efficient signal-based communication between components
- Well-structured and maintainable code

**Link to code**:
https://gitlab.ecs.vuw.ac.nz/course-work/cgra252/2024/project/team6/tower-defense/-/blob/main/Tower-Defense-Game/Scripts/InputManager/InputManager.gd

https://gitlab.ecs.vuw.ac.nz/course-work/cgra252/2024/project/team6/tower-defense/-/blob/main/Tower-Defense-Game/Scripts/InputManager/UpgradePopup.gd


## Problematic Code

The current implementation of `platform.gd` represents poorly written code, despite being functional for the current stage.

**Current Implementation Issues:**
- Simply checks if a point is inside a rectangular StaticBody2D
- Requires manual placement of multiple platforms to create valid tower positions
- Lacks proper path awareness
- Not scalable for different stage designs

**How It Should Be Improved:**
- Platform system should cover the entire stage
- Implement path detection system to automatically identify enemy routes
- Create dynamic "no-build zones" around paths using radius calculations
- Add methods to generate valid tower positions based on path layout

This design would make the code more reusable and allow for easy creation of different stages without manual platform placement.

**Link to code**:
https://gitlab.ecs.vuw.ac.nz/course-work/cgra252/2024/project/team6/tower-defense/-/blob/main/Tower-Defense-Game/Scripts/stage/platform.gd


## AI Tools Usage

- **GitHub Copilot**:
   - Utilized throughout the game development process
   - Particularly useful for:
       - Generating documentation comments
       - Creating repetitive code patterns
       - Syntax checking and basic refactoring
   
   - Less effective for:
       - Creating completely new functions from scratch
       - Often generated overly complex code that didn't match intended design
       - Required careful review and modification of suggestions

   - Overall, while not reliable for core logic implementation, it significantly improved development efficiency for routine tasks and documentation.

- **Claude**:
   - Documentation assistance:
       - Invaluable for non-native English speakers
       - Helped with proofreading and spell-checking
       - Could refine rough drafts into proper documentation
       - Tended to exaggerate achievements (Maybe this is English thing)
       - Required balancing between AI suggestions and personal voice

   - Debugging support:
       - Generated comprehensive debug print statements
       - Helped identify logic errors (boundary conditions, > or >=)
       - Discovered its usefulness in deciphering poorly written existing code during development

   - Code development:
       - Similar to Copilot: sometimes generated overcomplicated solutions
       - Unlike Copilot: could help simplify approaches when asked
       - Required oversight due to limited understanding of full project context

   - Overall highly beneficial, but needed constant validation against project requirements and design intentions


## Learning Reflection

*Note: As the primary author of the group reflection, some of my personal insights naturally overlapped with the group reflection. Here, I focus on my individual growth and specific learnings from this experience.*

### Personal Growth

This project challenged me to develop in multiple aspects of software development.

In technical development, I faced the challenge of integrating multiple complex systems, which taught me the importance of proper planning and documentation. The lack of UML diagrams and common module definitions at the start led to integration difficulties, highlighting how crucial these design elements are. This experience emphasized the value of well-structured code and clear interfaces between components.

The experience of taking over and improving existing code significantly enhanced my refactoring skills, while the need to accommodate future changes pushed me to develop more flexible and maintainable systems.

The project's management challenges led to unexpected learning experiences. As the team became smaller than anticipated, I had to adapt quickly, learning to redistribute tasks effectively and reorganize the project structure to match our available resources. This experience particularly improved my documentation and communication strategies, essential skills for maintaining project progress with a reduced team.

Perhaps most significantly, my approach to problem-solving evolved throughout the project. I discovered the value of abstract development when working with incomplete components, and learned to balance between ideal solutions and practical implementations given our resource constraints. The experience of debugging and analyzing poorly structured code enhanced my ability to understand and improve complex systems.

### Key Takeaway

A key learning came from redesigning the input system, where I learned the importance of user-centric design. By focusing on creating more intuitive and consistent interactions, and refactoring code for future extensibility, I gained valuable insights into how technical decisions directly impact user experience.

The most important takeaway from this project is understanding that successful software development requires both flexibility and solid foundations. While having clear shared understanding and commitment to design rules at the beginning is crucial, equally important is the ability to adapt to changes while maintaining code quality. This means not only being able to adjust to changing team dynamics and requirements, but also consistently focusing on clear documentation, maintainable code structure, and extensible system design. These principles will be essential for any future project, regardless of its scale or complexity.


## Submission Weighting

| Area        | Weight | Range   |
|-------------|--------|---------|
| Final Game  | 25%    | 10-30% |
| Good Code   | 25%    | 10-30% |
| Bad Code    | 15%    | 10-30% |
| Reflection  | 30%    | 20-40% |
| Video       | 5%     | 5-15%  |
# Individual Project Report

## Header Information
- **Name**: Nagare Negishi

- **Username**:
    - negishnaga
    - Initially : negimakushi

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

/////////////////////////////////////////////////////////////////

## Code Discussion
### Project Contributions

- **Level Management System** (\Scripts\level_manager)

- `game_stats.gd` [All]
    GameStats manages the game statistics such as score, life, and resources



    - LevelManager: Implemented complete game progression system
    - Stage: Developed core stage functionality and path system
    - InputController: Rebuilt tower placement and upgrade system
    - Tower System: Refactored and enhanced tower mechanics
    - Enemy System: Improved existing code with better class structure
    - HUD: Implemented game interface functionality






- documentation:
    most documentation are done by me (over 90%), readme.refrection md

- git use:
    most git planning and managing are done by me too. making issue, milastone, label, tags, managing issue board, release brach

- developed LevelManager:
    as developper initialy assign to develop the system manage game progression(wave creation, difficulty adjustment, game progression, and root of the game which connect everything),
    i developed entire code for that
    all script in LevelManager folder

- reorganized project:
    as we faced lack of participation from team mambers I changed task allocation and way we develop the project meet reality

- stage:
    made all code for stage functions. stage where tower in placed, path which followed by enemy
    all script in stage folder, visual of stage are made by other developper

- tower:
    take over tower development, it already had animation and base code but contained many bugs.
    i refactored code, fixed issue around aiming enemy. imlemented updrade, showing selected, attack range also add class name and made it super class.
    refactored and improved arrow class
    made thouderbolt tower as sub class of tower and thonder bolt for aoe
    all script in tower folder

- enemy:
    most code and all image are already done by other developper.
    to make it easy to managed by other class i added class name to all enemy refactored existing code to make super class.
    add few method to control it speed and few signals to communication

- hud:
    made script for hud. design and conponents are made by other developper.
    implemented buy tower, new wave button function
    refactored existing main menu script and created game over/ victory menu based on it
    also created scene manager to deal with scence change

- InputController:
    when i take it over there are code to drag and drop the tower, however i found moving tower already placed is unefficient and code wasnt working.
    I made entirely new input mangement system for tower placement and upgrade
    all script in inputmanager









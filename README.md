# Tower Defense
# CGRA252


# The title of the game

<TEMP>Goblins’ Fury: Fortress Fight</TEMP>

# IMPORTANT:

~~The code in this main branch currently contains multiple errors and is not functional.~~
Although many components are missing, the game is functioning. As we try to avoid modifying others' code as much as possible, communication between each component is not well handled yet.

Please also see the [back-up-nagare] branch for other version of the prototype.

# Your group name

[THIS IS TEMPORARY]
<TEMP>Team 6</TEMP>

# Names and roles of the team members
🐻 Eric Liu

🐺 Lawrence Huangfu

🐱 Bruno Helbick

🐶 Nagare Negishi

🐰 Brock Clarke

🦉 Angus Ng


# Link to video (onedrive/vimeo/youtube/googledrive other video service) showing the design of the game ( approx. 2-4 mins )

- https://drive.google.com/file/d/1G-85lo--mbkCuej0Jl6LQ6dVApytIs8x/view?usp=drive_link


# Game Description
What is the style of the game, what are similar games
- Tower Defense similar to Bloons TD

Our game is a classic 2D Tower Defense (TD) strategy game,
drawing inspiration from popular title Bloons TD.
The game combines strategic placement of defensive structures with resource management and quick decision-making.
Like Bloons TD, our game will feature a variety of tower types, each with unique abilities and upgrades.


What is the main game mechanic
- Before each round player sets up and upgrades towers
- Enemies spawn in waves and try to reach players base
- Player takes damage for every enemy that makes it through to base
- When base health reaches 0 game is over


**Pre-round Setup**:
- Players strategically place towers on the map before each wave begins
- Limited resources (money/points) for purchasing and upgrading towers
- Players can sell or relocate towers to adapt their strategy
**Wave-based Enemy Spawns**:
- Diverse enemy types with different speeds, health, and abilities
- Progressively challenging waves that test the player's defense
**Player Base and Health System**:
- Path end that players must protect
- Base health decreases when enemies reach it
- Game over when base health reaches zero
**Tower Mechanics**:
- Multiple tower types (e.g., projectile, area-of-effect, support)
- Upgrade for each tower, enhancing damage, range, or special abilities
**Resource Management**:
- Earn in-game currency by defeating enemies
- Balance between saving for powerful upgrades and immediate defense needs


A list of the challenging engine technology that will be learnt/used.

**Tower Upgrade System**:
- Implement a flexible superclass for tower upgrades
**Game Balance**:
- Develop a testing framework to balance tower damage with enemy health/scaling
**User Interface and HUD**:
- Create an intuitive, responsive UI for tower placement and upgrades
**Enemy Wave Management**:
- Design a system to manage increasingly difficult enemy waves
(Cant remember if we talk about it...
**Multiple Path Implementation**:
- Create a system to support multiple paths for enemies)



## A list of the challenging engine technology currently used.


## A list of the challenging engine technology that will be tested for the rest of the development.


## A list of features that have been implemented in the prototype:

- Basic Level Management: Temp_LevelManager implements a basic structure for managing game levels and waves.

## Prepared but NOT YET IMPLEMENTED Systems:

- GameStats: A system designed for tracking game resources and player stats. This system exists in code but is not yet connected to other game systems or actively tracking any data.

- StrengthEstimator: A framework intended for adjusting game difficulty. While the basic structure exists, it is not yet integrated or influencing gameplay.

- Wave/ Wave Generation: A basic structure for creating enemy waves has been outlined in code. However, this system is not yet functional or generating actual waves in the game.


## Controls: how to interact with the prototype


## List of Assets used/templates used:

https://free-game-assets.itch.io/free-field-enemies-pixel-art-for-tower-defense

https://free-game-assets.itch.io/free-fields-tileset-pixel-art-for-tower-defense

https://free-game-assets.itch.io/free-archer-towers-pixel-art-for-tower-defense

https://free-game-assets.itch.io/free-magic-and-traps-top-down-pixel-art-asset

https://foozlecc.itch.io/spire-tower-pack-1

https://foozlecc.itch.io/spire-tower-pack-2

https://foozlecc.itch.io/spire-tower-pack-3

https://foozlecc.itch.io/spire-tower-pack-4

https://foozlecc.itch.io/spire-enemy-pack-1

https://foozlecc.itch.io/spire-enemy-pack-2





# Rubric

| Area | Weighting | Default range |
|------|:---------:|:-------------:|
| Updates | | 0-20 |
| Prototype - Code | | 15-35 |
| Prototype - Plan | | 15-35 |
| Reflection | | 20-40 |
| Video | | 5-15 |


### Task Division

- Stage: Responsible for the game environment and coordinating tower and enemy positions/ path.
- Tower: Develops the tower system, including different types, upgrades, and attack mechanics.
- Enemy: Creates the enemy system, including different types, movement, and interaction with towers.
- HUD: Designs and implements all UI elements and information display.
- InputController: Manages all user interactions and game controls.
- LevelManager: Handles level progression, wave management, and difficulty scaling.

Each task was initially assigned to:

- Stage: 
- Tower: 
- Enemy: 
- HUD: 
- InputController: 
- LevelManager: Nagare Negishi

Each task was implemented by:

- Stage: 
- Tower: 
- Enemy: 
- HUD: 
- InputController: 
- LevelManager: Nagare Negishi
# Tower Defense
# CGRA252


# The title of the game

Goblins’ Fury: Fortress Fight

# IMPORTANT:

~~The code in this main branch currently contains multiple errors and is not functional.~~
Although many components are missing, the game is functioning. As we try to avoid modifying others' code as much as possible, communication between each component is not well handled yet.
->
As we tried to implement missing functionality at the last minute, there are some conflicts in the code, resulting in three different work-in-progress versions.

The version in the main branch will be used as our submission. It has a functional HUD and a working "Next Wave" button.

If possible, please also see the [back-up-nagare] and [last-backup-30-9] branches for other versions of the prototype:

- In the [last-backup-30-9] branch, there is a start menu, enemies respawn endlessly, and the "Buy Tower" button works as a hardcoded fixed version.

- The [back-up-nagare] branch does not have a HUD. However, in this version, towers level up as the game progresses, and arrows from towers home in on enemies.


# Your group name

Team 6

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

Note: While not strictly "engine technology," the following represents significant technical challenges we addressed in our development process:

- Scene Management and Inter-Component Communication: We learned some useful techniques to address challenges in our development process:
  1. Used debug logging to visualize node hierarchies, aiding in understanding scene structures.
  2. Implemented conditional node connections and error checking to prevent issues with missing nodes.
  3. Utilized Godot's signal system with additional safeguards to improve communication reliability between different parts of the game.


## A list of the challenging engine technology that will be tested for the rest of the development.

- User Input Handling for Drag and Drop:

  While it may not be extremely challenging, implementing a drag-and-drop system for tower placement is a new feature we plan to explore. This will involve:
  1. Detecting and processing mouse/touch input
  2. Creating a visual representation of the tower being dragged
  3. Implementing placement validation to ensure towers are only placed in valid locations
  4. Smoothly transitioning the tower from the dragged state to its final placed position

- Dynamic Wave Generation Algorithm:

  We might not have enough time to finish this feature, but We plan to create a system that makes enemy waves match how strong the player's towers are. This isn't really about engine technology, but it's important for making the game balanced and fun:

  1. Checking what towers the player has and how they're upgraded
  2. Figuring out how strong the player's defenses are
  3. Creating enemy waves that are challenging but not impossible
  4. Changing the difficulty as the player's defense gets stronger


## A list of features that have been implemented in the prototype:

- Basic Level Management: Temp_LevelManager implements a basic structure for managing game levels and waves.

## Prepared but NOT YET IMPLEMENTED Systems:

- GameStats: A system designed for tracking game resources and player stats. This system exists in code but is not yet connected to other game systems or actively tracking any data.

- StrengthEstimator: A framework intended for adjusting game difficulty. While the basic structure exists, it is not yet integrated or influencing gameplay.

- Wave/ Wave Generation: A basic structure for creating enemy waves has been outlined in code. However, this system is not yet functional or generating actual waves in the game.


## Controls: how to interact with the prototype

We have three different versions of the prototype, each with slightly different controls:

1. "Main" Branch Version:
   - The game starts automatically when the main scene is executed.
   - One wave of enemies spawns at the beginning.
   - After all enemies in a wave are defeated or the last enemy reaches the goal, the "Start Wave" button becomes active.
   - Press the "Start Wave" button to send another wave of enemies.

2. "Last-backup-30-9" Branch Version:
   - This version has a start menu.
   - Only the "Start Game" and "Quit" options are functional.
   - Press "Start Game" to move to the game scene and begin playing.
   - Enemy waves respawn endlessly.
   - When the player (tower) earns enough coins, the "Buy Tower" button activates.
   - Press "Buy Tower" to add a new tower to the scene (note: tower number and locations are currently hardcoded).

3. "Back-up-nagare" Branch Version:
   - This version has no interactive controls beyond the start menu.


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
| Updates | 10% | 0-20 |
| Prototype - Code | 25% | 15-35 |
| Prototype - Plan | 25% | 15-35 |
| Reflection | 30% | 20-40 |
| Video | 10% | 5-15 |


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
- HUD:
- InputController: Eric Liu ?
- LevelManager: Nagare Negishi

Each task was implemented by:

- Stage: Jinhao Huangfu(in progress), Brock Clarke(in progress)(the map in the prototype is done by him)
- Tower: Bruno Helbick(in progress)
- Enemy: Brock Clarke(in progress)
- HUD: HUD.tscn Brock Clarke(in progress), HUD.gd Nagare Negishi(in progress)
- InputController: Eric Liu(in progress), HUD.tscn Brock Clarke(in progress)(as HUD handling some buttons input)
- LevelManager: Nagare Negishi(in progress)
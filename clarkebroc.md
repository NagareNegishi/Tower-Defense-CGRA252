## Part 3 Individual contribution

### Student information

- Name : Brock Clarke
- Username : clarkebroc
- Project role : Initially Enemy implmentation but worked on Map, Hud, Settings menu, Target Aquisition
- Animal role : Rabbit - Communicatior Facilitator


## Group contribution

### Your contribution to the group.

My contribution to the group started with implementing the wave based system to the game this started out well and has been
more integrated with Nagares `wave.gd` and `EnemyPath.gd` as the project has moved along so my initial contribution to that is quite different from the initial implementation. As of the current date leading up to final
submission I have worked on aspects of the HUD, settings and main menu, design of the map and backdrops for the game/menus, added the music track, worked on target aquisition for the tower/arrows, my 
initial part of the project the enemy system and the videos for submisson.

### Your communication role and how you filfulled your roles

I personally feel considering the circumstances of me being a distance student my communication has been good I have personally tried my best to communicate the changes I have made accross to the team when 
I have made them, both through the issues I have put into the repository/smart commits and also where we had most of our discussions in our group discord chat though just learning how github really works for the first time
i beleive i could have put a better effort into creating issues and checklists. as for the facilitator I tried my best to fall 
into a role in the team that was needed where things weren't being worked on such as in the prototype submission the game was broken and when the tower tried to target an enemy the game would crash it was 
not a perfect fix but worked so that we would have a submission for the prototype. after submission I worked to make sure the target was getting a list of enemies entering its range and would add and pop 
them from the queue as needed. Also the design of the maps and main menus that were not done up until the late stages of the game development as the main focus was the code and getting the game running 
smoothly.

### Group dynamics and how the group worked together.

The team as a whole did not work so well together as we had dwindling communication thoughout the project as a whole we stuggled to put out our prototype as team members left what they 
did sumbit right up until the last minute leaving major coding flaws that needed quick fixing if we were to get our submission in at all. That being said there is one team member I did very much enjoy 
working with he had good communication and was very orgainised and led to the negativity of poor communication with the other team members being an afterthought as making the game with this other team 
member very enjoyable.

### Code discussion

My initial implementation of the wave spawner was run on a timer where the timer would time out every second and spawn enemies according to an enemy count in a wave data list this has since been changed to 
suit the game better as such I would call this my more messy or bad code as it had no connections or signals to other parts of the game and relied on its own logic within the script to manage the wave 
system (see spawner.gd for this) , in the current implementation it still works by instantiation of the enemy scenes that I created but now chooses a random enemy scene that is weighted by difficulty of the 
current player level and according to the enemy count for each wave will stop then. A part of my code I was most proud of was in the prototype implementation enemies were getting detected once on entry of 
the towers radius and getting fired at once I implemented the queuelike system to ensure the tower would keep firing at the first enemy until it was defeated or until it left the towers radius. Other work I 
contributed to was the main and settings menu and setup of the Hud mainly control of the pause/play part of the game and handling the music volume and some small animations to make the game feel more 
polished overall though it is not the most complex code I still believe it creates a better feeling for the player overall making it feel like a more polished thought out game.


### Learning reflection

The first thought that comes to mind for my reflection would be the importance of face to face communication with team members, this has been a very enlightening expeience as I am a distance student working 
by myself has been very managable as I only have had to be responisble for myself and face to face communication has not been as neccesary but I beleive that for this project this would have helped the team 
alot better and would have improved understanding of others code. That being said this is a lesson I will be taking into future interactions as I progress in my
study. For the coding and design it was a good eye opener into how others approach coding and implementation of thier own ideas as reading ones own code it alot easier to grasp it made for some improvements
in my own understanding of reading an implementing code, a great lesson to have. 

### Link To Personal Video Review

- https://drive.google.com/file/d/1RTF9A36bh_1WGYcKEZNwJlzeeTcPu8Y7/view?usp=sharing

### Pictures of code 

- https://drive.google.com/drive/folders/1bhgdVN3C0HGr88hPtHdc9Oq6KJc81dkr?usp=sharing

### Weighting

I have opted to leave my weighting as default


Area
default
range

Final Game
20%
(10-30)


Good code
20%
(10-30)


Bad code
20%
(10-30)


Reflection
30%
(20-40)


Video
10%
(5-15)




Code Components
When referring to the code you have worked on you can claim

- `EnemyBase.gd`  [Most]
    I personally developed the initial implementation of the enemies this later this was made into a superclass by a teammate so 
    some of my original code persists within this new script for all enemies as such the code is similar but has been made easier 
    to controll all emeies easier.

- `EnemyPath.gd`  [Half]
    Created the initial implementation for the enemy path some of my code taken from `spawner.gd` was used in the making of this


- `Wave.gd` [touched]
    I did not personally touch this script however my initial implementation was the spawner system so the enemy scenes and some
    of the logic are similar and somewhat based on what is originally done

- `TowerArrow1.gd`  [some/touched]
    I worked on fixing the arrow flight path as it wasnt originally targeting an enemy but flying in the direction of the enemy 
    on its entry of the tower radius. In my implementation targeted any enemy (Goblin, Wolf, ect) but got refactored for enemy superclass

- `Tower.gd` [some]
    I worked on improving the queue system to ensure the tower would continue targeting the first enemy on entry of its radius 
    and only move onto the next enemy after the first had either left the radius or been defeated.

- `Hud.gd` [Some]
    I made this script and linked the buy tower up to an earlier version of the tower before it was an image to be dropped. I also
    linked the pause button up to pause the game an open the mid game settings menu.

- `Mainmenu.gd` [some]
    Changed the design and added a path to the settings menu

- `settingsmenu.gd` [All]
    Added the sound change functionality and backout button

 - `NextWave.gd` [Half]
Added original implmentation

- `Pausemenu.gd` [Most]
    Made original implementation has since had a few links made to level manager




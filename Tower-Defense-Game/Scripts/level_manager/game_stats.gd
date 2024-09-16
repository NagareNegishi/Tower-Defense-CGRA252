extends Node
class_name GameStats

## GameStats manages the game statistics such as score, life, and resources.
## It uses signals to notify other parts of the game when these values change.

var score: int = 0
var life: int = 100
var resources: int = 1000

# HUD should listen to these signals
signal score_changed(new_score: int)
signal life_changed(new_life: int)
signal resources_changed(new_resources: int)

# Update the score
func update_score(amount: int):
	score += amount

# Update the life
func update_life(amount: int):
	life -= amount

# Update the resources
func update_resources(amount: int):
	resources += amount












# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

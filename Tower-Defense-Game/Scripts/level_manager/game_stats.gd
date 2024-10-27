extends Node
class_name GameStats

## GameStats manages the game statistics such as score, life, and resources.
## It uses signals to notify other parts of the game when these values change.

# HUD should listen to these signals
signal score_changed(new_score: int)
signal life_changed(new_life: int)
signal gold_changed(new_gold: int)
signal game_over

# Current score
var score: int = 0:
	set(value):
		score = value
		score_changed.emit(score)

# Current life
var life: int = 10:
	set(value):
		life = value
		life_changed.emit(life)
		if life <= 0:
			game_over.emit()

# Current resources
var gold: int = 1000:
	set(value):
		gold = value
		gold_changed.emit(gold)


# Update the score
func update_score(amount: int):
	score += amount

# Update the life
func update_life(amount: int):
	life -= amount
	print("Life: ", life)

# Update the resources
func update_resources(amount: int):
	gold += amount



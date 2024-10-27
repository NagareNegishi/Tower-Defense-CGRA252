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
		if value < gold:
			total_gold_spent += gold - value
		gold = value
		gold_changed.emit(gold)
# statistics for estimation
var towers_built: int = 0
var total_enemies_spawned: int = 0
var enemies_defeated: int = 0
var enemies_reached_goal: int = 0
var total_gold_spent: int = 0

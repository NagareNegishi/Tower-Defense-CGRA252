extends Node
class_name StrengthEstimator

## StrengthEstimator estimates the player's strength and the difficulty of the level.
## The player's strength is estimated based on the number of towers built, the defeat rate, and the resource efficiency.

@onready var game_stats: GameStats = get_node("/root/Game/GameStats")
const MIN_STRENGTH: float = 0.5
const MAX_STRENGTH: float = 2.0
const TOWER_FACTOR: float = 0.5 # probably most important factor
const DEFEAT_RATE_FACTOR: float = 2.0
const RESOURCE_FACTOR: float = 1000.0
@export var difficulty_limit: int = 30

# estimate the player's strength from 3 factors and divide by 3
func estimate_player() -> float:
	# default strength
	if !game_stats:
		return 1.0
	# factor 1: tower strength
	var tower_strength = game_stats.towers_built * TOWER_FACTOR
	# factor 2: defeat rate
	var defeat_rate = 0.0
	if game_stats.total_enemies_spawned > 0:
		defeat_rate = float(game_stats.enemies_defeated) / game_stats.total_enemies_spawned
		defeat_rate *= DEFEAT_RATE_FACTOR
	# factor 3: resource efficiency
	var resource_efficiency = 0.0
	if game_stats.total_gold_spent > 0:
		resource_efficiency = float(game_stats.enemies_defeated) / game_stats.total_gold_spent * RESOURCE_FACTOR
	# average the 3 factors
	var strength = (tower_strength + defeat_rate + resource_efficiency) / 3.0
	return clampf(strength, MIN_STRENGTH, MAX_STRENGTH) # balance the strength

# estimate the difficulty of the level based on the current level and the player's strength
func estimate_difficulty(current_level: int) -> int:
	var player_strength = estimate_player()
	var base_difficulty = current_level
	# estimate the success rate
	var success_rate = 0.0
	if game_stats.total_enemies_spawned > 0:
		success_rate = 1.0 - game_stats.enemies_reached_goal / float(game_stats.total_enemies_spawned)
	# adjust the difficulty based on the success rate
	var difficulty = base_difficulty * player_strength
	if success_rate < 0.7:
		difficulty *= 0.9
	elif success_rate > 0.9:
		difficulty *= 1.1
	return int(clampf(difficulty, base_difficulty * 2, difficulty_limit)) # limit the difficulty to a reasonable range


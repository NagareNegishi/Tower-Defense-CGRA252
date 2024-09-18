extends Node
class_name StrengthEstimator

func estimate_player_strength() -> float:
	return 1.0

func estimate_enemy_strength(wave_number: int) -> float:
	return float(wave_number)

func calculate_next_wave_difficulty(player_strength: float, current_wave: int) -> int:
	return int(player_strength + current_wave)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


## best i can do without knowing others code

# lets assume
# Default enemy strengths
const ENEMY_STRENGTHS = {
    "basic": 10,
    "fast": 15,
    "tank": 25,
    "boss": 50
}

# Difficulty adjustment factors
const DIFFICULTY_DECREASE_FACTOR = 0.9
const DIFFICULTY_INCREASE_FACTOR = 1.1

var current_difficulty: float = 1.0
var enemies_reached_goal: int = 0
var total_enemies_spawned: int = 0
var waves_completed: int = 0


func estimate_wave_strength(wave_number: int, enemy_types: Array) -> float:
	var strength = 0.0
	for enemy_type in enemy_types:
		strength += ENEMY_STRENGTHS.get(enemy_type, ENEMY_STRENGTHS["basic"])
	return strength * current_difficulty * (1 + wave_number * 0.1)

func enemy_reached_goal():
	enemies_reached_goal += 1
	adjust_difficulty()

func wave_completed(enemies_spawned: int):
	total_enemies_spawned += enemies_spawned
	waves_completed += 1
	adjust_difficulty()

func adjust_difficulty():
	var success_rate = 1.0 - (float(enemies_reached_goal) / total_enemies_spawned)
	if success_rate < 0.7:  # If more than 30% of enemies reached the goal
		current_difficulty *= DIFFICULTY_DECREASE_FACTOR
	elif success_rate > 0.9:  # If less than 10% of enemies reached the goal
		current_difficulty *= DIFFICULTY_INCREASE_FACTOR
	current_difficulty = clamp(current_difficulty, 0.5, 2.0)  # Limit difficulty range
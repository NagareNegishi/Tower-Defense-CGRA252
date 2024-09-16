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

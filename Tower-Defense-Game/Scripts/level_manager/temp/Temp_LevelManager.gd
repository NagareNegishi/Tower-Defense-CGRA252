extends Node
class_name Temp_LevelManager

var current_level = 1
var total_levels = 5
var current_state = GameState.BETWEEN_WAVES

enum GameState {
	WAVE_IN_PROGRESS,
	BETWEEN_WAVES,
	GAME_OVER,
	VICTORY
}

@onready var game_stats: GameStats = $"../GameStats"
@onready var strength_estimator: StrengthEstimator = $"../StrengthEstimator"
@onready var spawner: Node2D = $"../Spawner"
@onready var hud: Control = $"../HUD"

# Initially enable the Next Wave button


signal level_complete
signal player_defeat
signal game_complete
signal add_tower




var can_send_next_wave = false

func _ready():
	game_stats.connect("game_over", Callable(self, "_on_game_over"))
	spawner.connect("wave_completed", Callable(self, "_on_wave_completed"))
	spawner.connect("enemy_reached_goal", Callable(self, "_on_enemy_reached_goal"))
	spawner.connect("next_wave_ready", Callable(self, "_on_next_wave_ready"))

	hud.connect("next_wave_requested", Callable(self, "_on_next_wave_requested"))
	print("LevelManager: Next wave requested signal connected")
	hud.connect("buy_tower_requested", Callable(self, "_on_buy_tower_requested"))
	print("LevelManager: Buy tower requested signal connected")



func start_level():
	current_state = GameState.WAVE_IN_PROGRESS
	spawner.start_wave()



func _on_wave_completed():
	current_state = GameState.BETWEEN_WAVES
	var player_strength = strength_estimator.estimate_player_strength()
	var next_wave_difficulty = strength_estimator.calculate_next_wave_difficulty(player_strength, Global.currentWave)
	strength_estimator.adjust_difficulty()
	can_send_next_wave = true
	
	if Global.currentWave >= spawner.wave_data.size():
		_on_level_complete()
	else:
		await get_tree().create_timer(3.0).timeout  # wait 3 seconds before starting the next wave
		start_level()

func _on_level_complete():
	current_level += 1
	if current_level > total_levels:
		current_state = GameState.VICTORY
		game_complete.emit()
	else:
		level_complete.emit()
		spawner.resetCurrentWave()
		spawner.start_wave()

		# reset spawner for next level

func _on_game_over():
	current_state = GameState.GAME_OVER
	player_defeat.emit()

# This function is called when the player kills an enemy
func update_stats_enemy_killed():
	game_stats.update_score(10)
	game_stats.update_resources(5)

func update_stats_enemy_reached_end():
	game_stats.update_life(1)
	strength_estimator.enemy_reached_goal()

func _on_enemy_reached_goal():
	print("LevelManager: Enemy reached goal")
	update_stats_enemy_reached_end()

# This function is called when the player requests the next wave
func _on_next_wave_requested():
	if can_send_next_wave:
		can_send_next_wave = false
		
		spawner.reset_CurrentWave()
		print("LevelManager: Wave has been reset")
		spawner.start_wave()
		print("LevelManager: Next wave requested")

func _on_next_wave_ready():
	print("LevelManager: Next wave ready")

func _on_buy_tower_requested():
	print("LevelManager: Buy tower requested")
	add_tower.emit()
	





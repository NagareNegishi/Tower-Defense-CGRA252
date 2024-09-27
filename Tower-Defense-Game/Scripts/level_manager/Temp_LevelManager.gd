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

signal level_complete
signal player_defeat
signal game_complete

func _ready():
    game_stats.connect("game_over", Callable(self, "_on_game_over"))
    spawner.connect("wave_completed", Callable(self, "_on_wave_completed"))

func start_level():
    current_state = GameState.WAVE_IN_PROGRESS
    spawner.start_wave()

func _on_wave_completed():
    current_state = GameState.BETWEEN_WAVES
    var player_strength = strength_estimator.estimate_player_strength()
    var next_wave_difficulty = strength_estimator.calculate_next_wave_difficulty(player_strength, spawner.currentWave)
    strength_estimator.adjust_difficulty()
    
    if spawner.currentWave >= spawner.waves.size():
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
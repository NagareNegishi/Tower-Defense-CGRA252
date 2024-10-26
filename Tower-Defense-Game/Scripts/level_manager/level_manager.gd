extends Node
class_name LevelManager

var waves = [] # for prototype
var current_wave: Wave = null
var next_wave: Wave = null
var total_waves = 5 # 5 to 10 waves per level
var current_level = 1
var total_levels = 5
var current_difficulty = 1
var current_state = GameState.BETWEEN_WAVES
enum GameState {
	WAVE_IN_PROGRESS,
	BETWEEN_WAVES,
	GAME_OVER,
	VICTORY
}

@export var game_stats: GameStats
@export var enemy_path: EnemyPath
@export var strength_estimator: StrengthEstimator  #I need to wait others code
var wave_scene = preload("res://Scenes/level_manager/wave.tscn")

signal waves_complete # finished sending all waves
signal level_complete # all waves are defeated
signal player_defeat # player lost
signal game_complete # player won

# Called when the node enters the scene tree for the first time.
func _ready():
	game_stats = get_node("/root/Game/GameStats")
	enemy_path = get_node("/root/Game/Stage/Path2D")
	game_stats.game_over.connect(_on_game_over)
	generate_waves()

# generate waves for the level and set the difficulty
func generate_waves():
	for i in range(total_waves):
		var wave = wave_scene.instantiate()
		wave.create(current_difficulty)
		waves.append(wave)

func next_level():
	if current_state != GameState.BETWEEN_WAVES:
		print("Cannot start next level")##############################################
		return
	current_difficulty += 1 #strength_estimator.get_difficulty()
	generate_waves()
	start_level()

func start_level():
	send_waves()

# send waves to the path
func send_waves():
	current_state = GameState.WAVE_IN_PROGRESS
	while not waves.is_empty():
		print("waveleft: ", waves.size())############################################
		current_wave = waves.pop_front()
		add_child(current_wave)
		# connect signals from wave
		current_wave.enemy_spawned.connect(_on_enemy_spawned)
		current_wave.wave_completed.connect(_on_wave_completed)
		current_wave.wave_defeated.connect(_on_wave_defeated)
		current_wave.start()
		await current_wave.wave_completed
		await get_tree().create_timer(3.0).timeout # wait for 3 seconds before sending next wave
		total_waves -= 1
	waves_complete.emit()

# called when the wave is completed
func _on_level_complete():
	current_state = GameState.BETWEEN_WAVES
	current_level += 1
	if current_level > total_levels:
		current_state = GameState.VICTORY
		game_complete.emit()

# called when the player is defeated
func _on_game_over():
	current_state = GameState.GAME_OVER
	player_defeat.emit()


func _on_wave_defeated():
	if waves.is_empty():
		_on_level_complete()

func _on_enemy_spawned(enemy):
	var spawned_enemy = enemy_path.spawn_enemy(enemy)
	spawned_enemy.reached_goal.connect(_on_enemy_reached_goal)
	spawned_enemy.enemy_died.connect(_on_enemy_killed)

func _on_enemy_reached_goal():
	game_stats.update_life(1)

func _on_enemy_killed():
	game_stats.update_score(10)
	game_stats.update_resources(5)


func _on_wave_completed():
	print("Wave completed")

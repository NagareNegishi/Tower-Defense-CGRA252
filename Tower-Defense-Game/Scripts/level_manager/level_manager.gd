extends Node
class_name LevelManager

var waves = []
var active_enemies: int = 0
var current_wave: Wave = null
var total_waves = 5 # 5 to 10 waves per level
var current_level = 1
var total_levels = 10
var current_difficulty = 1
var current_state = GameState.BETWEEN_WAVES
enum GameState {
	WAVE_IN_PROGRESS,
	BETWEEN_WAVES,
	GAME_OVER,
	VICTORY
}
var all_waves_sent = false
var level_completed = false

@export var game_stats: GameStats
@export var enemy_path: EnemyPath
@export var strength_estimator: StrengthEstimator
var wave_scene = preload("res://Scenes/Level_Manager/wave.tscn")

signal level_complete # all waves are defeated
signal player_defeat # player lost
signal game_complete # player won

# Called when the node enters the scene tree for the first time.
func _ready():
	game_stats = get_node("/root/Game/GameStats")
	enemy_path = get_node("/root/Game/Stage/Path2D")
	strength_estimator = get_node("/root/Game/StrengthEstimator")
	game_stats.game_over.connect(_on_game_over)
	generate_waves()

# generate waves for the level and set the difficulty
func generate_waves():
	waves.clear()
	all_waves_sent = false
	for i in range(total_waves):
		var wave = wave_scene.instantiate()
		wave.create(current_difficulty)
		waves.append(wave)

# generate waves for the next level and start
func next_level():
	if current_state != GameState.BETWEEN_WAVES:
		return
	current_level += 1
	current_difficulty = strength_estimator.estimate_difficulty(current_level)
	generate_waves()
	start_level()

# start the level
func start_level():
	if waves.is_empty():
		print("No waves generated!")
		return
	active_enemies = 0
	level_completed = false
	send_waves()

# send waves to the path
func send_waves():
	current_state = GameState.WAVE_IN_PROGRESS
	while not waves.is_empty():
		current_wave = waves.pop_front()
		add_child(current_wave)
		# connect signals from wave
		current_wave.enemy_spawned.connect(_on_enemy_spawned)
		current_wave.wave_defeated.connect(_on_wave_defeated)
		current_wave.start()
		await current_wave.wave_completed
		if waves.is_empty():
			all_waves_sent = true
		await get_tree().create_timer(3.0).timeout # wait for 3 seconds before sending next wave

# connect signals from enemy
func _on_enemy_spawned(enemy):
	var spawned_enemy = enemy_path.spawn_enemy(enemy)
	spawned_enemy.reached_goal.connect(_on_enemy_reached_goal)
	spawned_enemy.enemy_died.connect(_on_enemy_killed)
	active_enemies += 1
	game_stats.total_enemies_spawned += 1

# check if the level is completed
func check_level_completion():
	if current_state == GameState.GAME_OVER:
		return
	if all_waves_sent and active_enemies <= 0 and waves.is_empty():
		_on_level_complete()

# called when an enemy reaches the goal
func _on_enemy_reached_goal(damage: int):
	game_stats.life -= damage
	active_enemies -= 1
	game_stats.enemies_reached_goal += 1
	check_level_completion()

# called when an enemy is killed
func _on_enemy_killed(reward: int):
	game_stats.gold += reward
	active_enemies -= 1
	game_stats.enemies_defeated += 1
	check_level_completion()

# check if the level is completed
func _on_wave_defeated():
	check_level_completion()

# check if the game is completed
func _on_level_complete():
	if level_completed:
		return
	level_completed = true
	current_state = GameState.BETWEEN_WAVES
	if current_level >= total_levels:
		current_state = GameState.VICTORY
		game_complete.emit()
	else:
		level_complete.emit()

# called when the player is defeated
func _on_game_over():
	if current_state == GameState.GAME_OVER:
		return
	current_state = GameState.GAME_OVER
	# cleanup
	if current_wave:
		current_wave.queue_free()
		current_wave = null
	waves.clear()
	active_enemies = 0
	player_defeat.emit()

# reset the level manager
func reset():
	waves.clear()
	active_enemies = 0
	if current_wave:
		current_wave.queue_free()
	current_wave = null
	total_waves = 5
	current_level = 1
	total_levels = 10
	current_difficulty = 1
	current_state = GameState.BETWEEN_WAVES
	all_waves_sent = false
	level_completed = false
	generate_waves()

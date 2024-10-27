extends Node
class_name LevelManager

var waves = []
var active_enemies: int = 0
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
var current_wave_defeated = false

@export var game_stats: GameStats
@export var enemy_path: EnemyPath
@export var strength_estimator: StrengthEstimator
var wave_scene = preload("res://Scenes/level_manager/wave.tscn")

signal waves_complete # finished sending all waves
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
	print("Generating waves for level ", current_level, " with difficulty ", current_difficulty)#########################
	for i in range(total_waves):
		var wave = wave_scene.instantiate()
		wave.create(current_difficulty)
		waves.append(wave)

# generate waves for the next level and start
func next_level():
	if current_state != GameState.BETWEEN_WAVES:
		return
	current_level += 1
	print("Starting level ", current_level)###################
	current_difficulty = strength_estimator.estimate_difficulty(current_level)
	print("Difficulty: ", current_difficulty)######################
	generate_waves()
	start_level()

# start the level
func start_level():
	if waves.is_empty():########################
		print("No waves generated!")
		return
	print("Starting level ", current_level, " with ", waves.size(), " waves")##################
	active_enemies = 0
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
		if not current_wave_defeated:
			await current_wave.wave_defeated
		await get_tree().create_timer(1.0).timeout # wait for 3 seconds before sending next wave###############################
	waves_complete.emit()

# connect signals from enemy
func _on_enemy_spawned(enemy):
	var spawned_enemy = enemy_path.spawn_enemy(enemy)
	spawned_enemy.reached_goal.connect(_on_enemy_reached_goal)
	spawned_enemy.enemy_died.connect(_on_enemy_killed)
	active_enemies += 1
	game_stats.total_enemies_spawned += 1

# called when an enemy reaches the goal
func _on_enemy_reached_goal(damage: int):
	game_stats.life -= damage
	active_enemies -= 1
	game_stats.enemies_reached_goal += 1

# called when an enemy is killed
func _on_enemy_killed(reward: int):
	game_stats.gold += reward
	active_enemies -= 1
	game_stats.enemies_defeated += 1

# check if the level is completed
func _on_wave_defeated():
	current_wave_defeated = true
	if waves.is_empty():
		_on_level_complete()

# check if the game is completed
func _on_level_complete():
	current_state = GameState.BETWEEN_WAVES
	print("Level completed"+ str(current_level))
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
	waves.clear()
	active_enemies = 0
	player_defeat.emit()

extends Node
class_name Wave

signal wave_completed # finished sending all enemies
signal wave_defeated # all enemies are defeated
signal enemy_spawned(enemy)

@export var slime_scene: PackedScene
@export var bee_scene: PackedScene
@export var wolf_scene: PackedScene
@export var goblin_scene: PackedScene
@export var strong_wolf_scene: PackedScene
@export var boss_goblin_scene: PackedScene

# limits of difficulty
@export var enemy_count_limit: int = 50
@export var interval_limit: float = 0.1
# initial values
@export var difficulty_level: int = 1
@export var max_interval: float = 1.5
@export var min_interval: float = 0.8
@export var wave_enemy_count: int = 3

var enemies = []
var enemy_count: int
var enemies_spawned = 0
var enemies_remaining = 0
var difficulty: int
var enemy_weights = {
	"slime": 60,
	"bee": 20,
	"wolf": 10,
	"goblin": 5,
	"strong wolf": 3,
	"boss goblin": 2
}

# this is just safe guard
func _ready():
	if not difficulty:
		create(1)

# this is real constructor
func create(new_difficulty: int):
	difficulty = new_difficulty
	adjust_wave_parameters()
	adjust_enemy_weights()
	enemies_remaining = enemy_count
	generate_enemies()

# adjust wave parameters based on difficulty
func adjust_wave_parameters():
	enemy_count = mini(wave_enemy_count + (difficulty * 2), enemy_count_limit)
	var min_reduction = (difficulty - 1) * 0.15
	var max_reduction = (difficulty - 1) * 0.1
	max_interval = max(max_interval * (1.0 - max_reduction), interval_limit + 0.3)
	min_interval = max(min_interval * (1.0 - min_reduction), interval_limit)

# adjust enemy weights based on difficulty
func adjust_enemy_weights():
	enemy_weights = {
		"slime": calculate_weights(100, 1, 15, 20), # 100 % first -> 20% at least
		"bee": calculate_weights(20, 4, -5, 10), # from difficulty 4
		"wolf": calculate_weights(20, 6, -5, 0), # from difficulty 6
		"goblin": calculate_weights(5, 8, -5, 0), # from difficulty 8
		"strong wolf": calculate_weights(5, 10, -3, 0), # from difficulty 10
		"boss goblin": calculate_weights(5, 15, -3, 0) # from difficulty 10
	}

# helper method to calculate weights based on difficulty
func calculate_weights(base: int, min_difficulty: int, reduce: int, min_rate: int) -> int:
	if difficulty < min_difficulty: # too easy for this enemy
		return 0
	var weight = base - (reduce * (difficulty - min_difficulty)) #reduce slime, increase others
	return maxi(weight, min_rate) # at least min_rate

# get a random enemy scene based on weights
func get_random_enemy_scene() -> PackedScene:
	# calculate total weight
	var total = 0
	for weight in enemy_weights.values():
		total += weight

	var random_value = randi() % total # within the range of total weight
	var current = 0
	# add up the weights and return the enemy type, higher the weight, higher the chance
	for enemy_type in enemy_weights.keys():
		current += enemy_weights[enemy_type]
		if random_value < current:
			match enemy_type:
				"slime": return slime_scene
				"bee": return bee_scene
				"wolf": return wolf_scene
				"goblin": return goblin_scene
				"strong wolf": return strong_wolf_scene
				"boss goblin": return boss_goblin_scene
	return slime_scene # default

# At the creation of the wave, generate enemies
func generate_enemies():
	for i in range(enemy_count):
		var enemy_scene = get_random_enemy_scene()
		var enemy = enemy_scene.instantiate()
		# connect signals from enemy
		enemy.reached_goal.connect(_on_enemy_reached_end)
		enemy.enemy_died.connect(_on_enemy_died)
		enemies.append(enemy)

# level manager will call this function to send enemies
func start():
	send_enemies()

# send enemies one by one based on spawn interval
func send_enemies():
	while not enemies.is_empty():
		var enemy = enemies.pop_front()
		enemy_spawned.emit(enemy)
		enemies_spawned += 1
		if enemies.is_empty():
			await get_tree().create_timer(1.0).timeout # wait for 2 seconds before emitting wave completed
			wave_completed.emit()
			return
		var spawn_delay = randf_range(min_interval, max_interval)
		await get_tree().create_timer(spawn_delay).timeout

# called when an enemy reaches the goal
func _on_enemy_reached_end(_damage: int):
	enemies_remaining -= 1
	_check_wave()

# called when an enemy is killed
func _on_enemy_died(_reward: int):
	enemies_remaining -= 1
	_check_wave()

# check if the wave is completed
func _check_wave():
	if enemies_remaining <= 0:
		wave_defeated.emit()

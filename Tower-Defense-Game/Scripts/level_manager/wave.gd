extends Node
class_name Wave

signal wave_completed # finished sending all enemies
signal wave_defeated # all enemies are defeated
signal enemy_spawned(enemy)

@export var slime_scene: PackedScene
@export var bee_scene: PackedScene
@export var wolf_scene: PackedScene
@export var goblin_scene: PackedScene
# initial values
@export var difficulty_level: int = 1
@export var max_interval: float = 2.0
@export var min_interval: float = 1.0
@export var wave_enemy_count: int = 5

var enemies = []
var enemy_count: int
var enemies_spawned = 0
var enemies_remaining = 0
var spawn_interval: float
var spawn_interval_variation: float = 0.0 # randomly vary the spawn interval by this amount
var difficulty: int
var enemy_weights = {
	"slime": 70,
	"bee": 20,
	"wolf": 8,
	"goblin": 2
}

# this is just safe guard
func _ready():
	if not difficulty:
		create(1)

# this is real constructor
func create(new_difficulty: int):
	difficulty = new_difficulty
	spawn_interval = max_interval
	enemy_count = wave_enemy_count
	enemies_remaining = enemy_count
	adjust_enemy_weights()
	generate_enemies()

# adjust enemy weights based on difficulty, currently it is hardcoded
func adjust_enemy_weights():
	match difficulty:
		1:
			enemy_weights = {"slime": 100, "bee": 0, "wolf": 0, "goblin": 0}
		2:
			enemy_weights = {"slime": 70, "bee": 30, "wolf": 0, "goblin": 0}
		3:
			enemy_weights = {"slime": 40, "bee": 40, "wolf": 20, "goblin": 0}
		_:
			enemy_weights = {"slime": 30, "bee": 30, "wolf": 30, "goblin": 10}

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
			await get_tree().create_timer(2.0).timeout # wait for 2 seconds before emitting wave completed
			wave_completed.emit()
			return
		var spawn_delay = randf_range(min_interval, max_interval)
		await get_tree().create_timer(spawn_delay).timeout

## expecting to receive a signal like this
func _on_enemy_reached_end():
	enemies_remaining -= 1
	print("Enemy reached end. Remaining: ", enemies_remaining)
	_check_wave()


func _on_enemy_died():
	enemies_remaining -= 1
	print("Enemy died. Remaining: ", enemies_remaining)
	_check_wave()

func _check_wave():
	if enemies_remaining <= 0:
		wave_defeated.emit()

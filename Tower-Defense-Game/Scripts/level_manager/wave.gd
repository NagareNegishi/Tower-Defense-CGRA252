extends Node
class_name Wave

signal wave_completed # finished sending all enemies
signal wave_defeated # all enemies are defeated
signal enemy_spawned(enemy)

var enemies = []
var enemy_count: int
var enemies_spawned = 0
var enemies_remaining = 0
var spawn_interval: float
var spawn_interval_variation: float = 0.0 # randomly vary the spawn interval by this amount
var difficulty: int

# for testing purposes can modify from the inspector
@export var difficulty_level: int = 1
@export var wave_spawn_interval: float = 2.0
@export var wave_enemy_count: int = 10
@export var slime_scene: PackedScene
@export var bee_scene: PackedScene
@export var wolf_scene: PackedScene
@export var goblin_scene: PackedScene


var enemy_weights = {
	"slime": 70,
	"bee": 20,
	"wolf": 8,
	"goblin": 2
}


# Called when the node enters the scene tree for the first time.
func _ready():
	difficulty = difficulty_level
	spawn_interval = wave_spawn_interval
	enemy_count = wave_enemy_count
	enemies_remaining = enemy_count
	
	adjust_enemy_weights()
	generate_enemies()

func adjust_enemy_weights():
	match difficulty_level:
		1:
			enemy_weights = {"slime": 100, "bee": 0, "wolf": 0, "goblin": 0}
		2:
			enemy_weights = {"slime": 70, "bee": 30, "wolf": 0, "goblin": 0}
		3:
			enemy_weights = {"slime": 40, "bee": 40, "wolf": 20, "goblin": 0}
		_:
			enemy_weights = {"slime": 30, "bee": 30, "wolf": 30, "goblin": 10}


func get_random_enemy_scene() -> PackedScene:
	var total_weight = 0
	for weight in enemy_weights.values():
		total_weight += weight

	var random_value = randi() % total_weight
	var current_weight = 0

	for enemy_type in enemy_weights.keys():
		current_weight += enemy_weights[enemy_type]
		if random_value < current_weight:
			match enemy_type:
				"slime": return slime_scene
				"bee": return bee_scene
				"wolf": return wolf_scene
				"goblin": return goblin_scene
	return slime_scene



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
		# add_child(enemy)
		enemy_spawned.emit(enemy)
		enemies_spawned += 1
		# this will spawn enemies but enemys movement or lacation need to wait teams code

		if enemies.is_empty():
			await get_tree().create_timer(2.0).timeout # wait for 2 seconds before emitting wave completed
			wave_completed.emit()
			return

		var spawn_delay = spawn_interval + randf_range(-spawn_interval_variation, spawn_interval_variation)
		await get_tree().create_timer(spawn_delay).timeout

## expecting to receive a signal like this
func _on_enemy_reached_end():
	# enemies_remaining -= 1
	print("Enemy reached end. Remaining: ", enemies_remaining)
	_check_wave()


func _on_enemy_died():
	enemies_remaining -= 1
	print("Enemy died. Remaining: ", enemies_remaining)
	_check_wave()

func _check_wave():
	if enemies_remaining <= 0:
		wave_defeated.emit()

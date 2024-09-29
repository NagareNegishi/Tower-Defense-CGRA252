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
@export var wave_spawn_interval: float = 1.0
@export var wave_enemy_count: int = 5

@export var enemy_scene: PackedScene



# Called when the node enters the scene tree for the first time.
func _ready():
	difficulty = difficulty_level
	spawn_interval = wave_spawn_interval
	enemy_count = wave_enemy_count
	enemies_remaining = enemy_count

	generate_enemies()


# At the creation of the wave, generate enemies
func generate_enemies():
	for i in range(enemy_count):
		var enemy = enemy_scene.instantiate()
		# do i adjust difficulty? or enemy has set of difficulty? ideally latter
		enemy.health = 100 + (difficulty * 10)
		enemy.speed = 50 + (difficulty * 5)

		enemies.append(enemy)

# level manager will call this function to send enemies
func start():
	send_enemies()

# send enemies one by one based on spawn interval
func send_enemies():
	while not enemies.empty():
		var enemy = enemies.pop_front()
		# add_child(enemy)
		enemy_spawned.emit(enemy)
		enemies_spawned += 1
		# this will spawn enemies but enemys movement or lacation need to wait teams code

		if enemies.empty():
			await get_tree().create_timer(2.0).timeout # wait for 2 seconds before emitting wave completed
			wave_completed.emit()
			return

		var spawn_delay = spawn_interval + randf_range(-spawn_interval_variation, spawn_interval_variation)
		await get_tree().create_timer(spawn_delay).timeout

## expecting to receive a signal like this
func _on_enemy_reached_end():
	enemies_remaining -= 1
func _on_enemy_died():
	enemies_remaining -= 1
	if enemies_remaining == 0:
		wave_defeated.emit()

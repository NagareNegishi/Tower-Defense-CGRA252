extends Node2D

# Variables to handle wave spawns
var current_wave = 0
var current_enemy_count = 0
var enemies_to_spawn = 0

# Define wave data (number of enemies per wave, and other properties)
var wave_data = [
	{ "enemy_count": 5, "enemy_scene": preload("res://Scenes/Waves/Wave1.tscn") },
	{ "enemy_count": 7, "enemy_scene": preload("res://Scenes/Waves/Wave2.tscn") },
	{ "enemy_count": 10, "enemy_scene": preload("res://Scenes/Waves/Wave3.tscn") }
]

# Signals (used for managing waves and enemies)
signal wave_completed
signal enemy_reached_goal

func _ready():
	# Prepare for first wave
	start_wave()

func start_wave():
	# Ensure there's a valid wave to start
	if current_wave < wave_data.size():
		# Set up the number of enemies to spawn in the current wave
		enemies_to_spawn = wave_data[current_wave]["enemy_count"]
		current_enemy_count = 0
		# Start the timer to spawn enemies one by one
		$Timer.start()

func _on_timer_timeout():
	# Check if all enemies in the current wave have been spawned
	if current_enemy_count < enemies_to_spawn:
		# Spawn the enemy and increment the count
		print("new enemy")
		spawn_enemy()
		current_enemy_count += 1
	else:
		# Stop spawning when the wave is completed
		$Timer.stop()
		emit_signal("wave_completed")
		current_wave += 1

func spawn_enemy():
	# Instantiate and add the enemy to the scene
	var enemy_scene = wave_data[current_wave]["enemy_scene"].instantiate()
	add_child(enemy_scene)
	
	# Optionally connect signals or set properties for the new enemy
	# For example, if enemy reaches goal:
	# enemy_scene.connect("reached_goal", Callable(self, "_on_enemy_reached_goal"))

func _on_enemy_reached_goal():
	# Recycle the enemy (if pooling) or handle logic for when an enemy reaches its destination
	emit_signal("enemy_reached_goal")

# Start the next wave after the current one is completed
func _on_wave_completed():
	start_wave()

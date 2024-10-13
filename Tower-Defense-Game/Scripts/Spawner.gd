extends Node2D


#variables to handle wave spawns

var previousWave = 0
var enemies_to_spawn = 0
var current_wave = Global.currentWave
#array for wave scenes
#var waves = [
	#preload("res://Scenes/Waves/Wave1.tscn"),
	#preload("res://Scenes/Waves/Wave2.tscn"),
	#preload("res://Scenes/Waves/Wave3.tscn"),
	#preload("res://Scenes/Waves/Wave4.tscn"),
	#preload("res://Scenes/Waves/Wave5.tscn"),
	#preload("res://Scenes/Waves/Wave6.tscn"),
	#preload("res://Scenes/Waves/Wave7.tscn")
	#]
	
var wave_data = [
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave1.tscn") },
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave2.tscn") },
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave3.tscn") },
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave4.tscn") },
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave5.tscn") },
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave6.tscn") },
	{ "enemy_count": 1, "enemy_scene": preload("res://Scenes/Waves/Wave7.tscn") }
]

## modification by Nagi delete it later
signal wave_completed
signal enemy_reached_goal
signal next_wave_ready
##########################




func _process(delta):

	if Global.prepWave == true:
		on_wave_completed()

func start_wave():
	# print("Starting new wave")
	#if wave is ready to spawn and there are still waves to be spawned
	if Global.currentWave < wave_data.size():
		
		enemies_to_spawn = wave_data[current_wave]["enemy_count"]
		
		#reset enemy count
		Global.enemyCount = 0
		
		#restart timer
		$Timer.start()
		#increment wave count
		

func _on_timer_timeout():
	if Global.enemyCount < wave_data.size():
		
		spawn_enemy()
		Global.enemyCount += 1
		
	else:
		$Timer.stop()
		Global.currentWave += 1
		#ensure next wave cannot spawn
		Global.waveReady = false
		Global.prepWave = true
		
	## delete this block############
		#print("Connecting signals for new wave")
		#for path_follow in wave_data.get_children():
			#if path_follow is PathFollow2D and path_follow.get_child_count() > 0:
				#var enemy = path_follow.get_child(0)
				#print("Enemy node: ", enemy.name, " - Class: ", enemy.get_class())
				#if enemy.has_signal("reached_goal"):
					#print("Connecting reached_goal signal for ", enemy.name)
					#enemy.connect("reached_goal", Callable(self, "_on_enemy_reached_goal"))
				#else:
					#print(enemy.name, " does not have reached_goal signal")
	########################


		#Stop further enemies from spawning
		
			

func spawn_enemy():
	var enemy = wave_data[Global.currentWave]["enemy_scene"].instantiate()
	add_child(enemy)

#enables ability to start next wave
func on_wave_completed():
	if Global.waveReady == true:
		start_wave()
		Global.prepWave = false
	

# modification by Nagi delete it later
	wave_completed.emit()


## delete this block############
func _on_enemy_reached_goal():
	#print("Spawner: Enemy reached goal")
	emit_signal("enemy_reached_goal")
########################

func resetCurrentWave():
	pass
	"""currentWave = 0
	$Timer.stop()"""
	


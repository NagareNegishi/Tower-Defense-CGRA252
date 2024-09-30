extends Node2D

#variables to handle wave spawns

var currentWave = 0

var HUD_scene = preload("res://Scenes/HUD.tscn")
#array for wave scenes
var waves = [
	preload("res://Scenes/Waves/Wave1.tscn"),
	preload("res://Scenes/Waves/Wave2.tscn"),
	preload("res://Scenes/Waves/Wave3.tscn"),
	preload("res://Scenes/Waves/Wave4.tscn"),
	preload("res://Scenes/Waves/Wave5.tscn"),
	preload("res://Scenes/Waves/Wave6.tscn"),
	preload("res://Scenes/Waves/Wave7.tscn")
]

## modification by Nagi delete it later
signal wave_completed
signal enemy_reached_goal
##########################

func _ready():
	#wave button doesnt work yet
	var HUD_instance = HUD_scene.instantiate()
	add_child(HUD_instance)
	var start_wave_button = HUD_instance.get_node("CanvasLayer/Next Wave")
	start_wave_button.connect("start_wave_signal", Callable(self, "start_wave"))


func _process(delta):
	print(currentWave)
	print(Global.enemyCount)

func start_wave():
	#if wave is ready to spawn and there are still waves to be spawned
	if Global.waveReady and currentWave <= waves.size():
		#prevent further waves from spawning
		Global.waveReady = false
		#reset enemy count
		Global.enemyCount = 0
		#restart timer
		$Timer.start()
		#increment wave count
		currentWave += 1

func _on_timer_timeout():
	if currentWave < waves.size():
		#intantiate current wave
		var waveScene = waves[currentWave].instantiate()
		#new child for new enemy
		add_child(waveScene)
		#increment enemy count

	## delete this block############
		#print("Connecting signals for new wave")
		for path_follow in waveScene.get_children():
			if path_follow is PathFollow2D and path_follow.get_child_count() > 0:
				var enemy = path_follow.get_child(0)
				print("Enemy node: ", enemy.name, " - Class: ", enemy.get_class())
				if enemy.has_signal("reached_goal"):
					#print("Connecting reached_goal signal for ", enemy.name)
					enemy.connect("reached_goal", Callable(self, "_on_enemy_reached_goal"))
				#else:
					#print(enemy.name, " does not have reached_goal signal")
	########################



	if currentWave < 4:
		Global.enemyCount += 1
	else:
		Global.enemyCount += 2
	#currently spawns 10 enemies per wave but can be adjusted for
	#each wave with a variable
	if Global.enemyCount >= 5:
		#stop timer when wave has reached max 
		$Timer.stop()
		#have these calls here to keep spawning waves can link this to a button for player to handle
		#spawning the next wave
		if Global.enemyCount >= 5:
			start_wave()
			on_wave_completed()
			


#enables ability to start next wave
func on_wave_completed():
	Global.waveReady = true
	

# modification by Nagi delete it later
	wave_completed.emit()


## delete this block############
func _on_enemy_reached_goal():
	#print("Spawner: Enemy reached goal")
	emit_signal("enemy_reached_goal")
########################

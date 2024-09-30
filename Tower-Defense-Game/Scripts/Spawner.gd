extends Node2D


#variables to handle wave spawns

var previousWave = 0

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
signal next_wave_ready
##########################

func _ready():
	#wave button doesnt work yet
	var HUD_instance = HUD_scene.instantiate()
	add_child(HUD_instance)
	var start_wave_button = HUD_instance.get_node("CanvasLayer/Next Wave")
	start_wave_button.connect("start_wave_signal", Callable(self, "start_wave"))


func _process(delta):

	if Global.prepWave == true:
		on_wave_completed()

func start_wave():
	print("Starting new wave")
	#if wave is ready to spawn and there are still waves to be spawned
	if Global.waveReady and Global.currentWave < waves.size():
		#reset enemy count
		Global.enemyCount = 0
		#restart timer
		$Timer.start()
		#increment wave count
		

func _on_timer_timeout():
	if Global.currentWave <= waves.size() -1:
		#intantiate current wave
		var waveScene = waves[Global.currentWave].instantiate()
		#new child for new enemy
		add_child(waveScene)


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


	
	if Global.currentWave < 4:
		Global.enemyCount += 1
	else:
		Global.enemyCount += 2
	#currently spawns 10 enemies per wave but can be adjusted for
	#each wave with a variable
	if Global.enemyCount == 5:
		#ensure next wave cannot spawn
		Global.waveReady = false
		#Stop further enemies from spawning
		$Timer.stop()
		#ready prepWave
		Global.prepWave = true
		
			


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
	currentWave = 0
	$Timer.stop()
	


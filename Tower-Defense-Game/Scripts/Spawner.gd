extends Node2D

#variables to handle wave spawns
var waveReady = true
var currentWave = 0
var enemyCount = 0

#array for wave scenes
var waves = [
	preload("res://Scenes/Wave1.tscn"),
	preload("res://Scenes/Wave2.tscn"),
	preload("res://Scenes/Wave3.tscn"),
	preload("res://Scenes/Wave4.tscn")
]


func start_wave():
	#if wave is ready to spawn and there are still waves to be spawned
	if waveReady and currentWave < waves.size():
		#prevent further waves from spawning
		waveReady = false
		#reset enemy count
		enemyCount = 0
		#restart timer
		$Timer.start()
		#increment wave count
		currentWave += 1

func _on_timer_timeout():
	#intantiate current wave
	var waveScene = waves[currentWave].instantiate()
	#new child for new enemy
	add_child(waveScene)
	#increment enemy count
	enemyCount += 1
	
	#currently spawns 10 enemies per wave but can be adjusted for
	#each wave with a variable
	if enemyCount >= 10:
		#stop timer when wave has reached max 
		$Timer.stop()
		#have these calls here to keep spawning waves can link this to a button for player to handle
		#spawning the next wave
		on_wave_completed()
		start_wave()

#function for player to spawn wave
func on_player_ready():
	if waveReady:
		start_wave()

#enables ability to start next wave
func on_wave_completed():
	waveReady = true

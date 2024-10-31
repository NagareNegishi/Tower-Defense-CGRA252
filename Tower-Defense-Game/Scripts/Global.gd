extends Node

# variables to be integrated into nagis level manager
var playerHealth = 50
var playerGold = 100
var isPaused = false
var waveReady = true
var enemyCount = 0
var currentWave = 0
var prepWave = false

# reset the game state
func reset_game_state() -> void:
	playerHealth = 50
	playerGold = 100
	isPaused = false
	waveReady = true
	enemyCount = 0
	currentWave = 0
	prepWave = false

# connect a signal to a target method if it is not already connected
func connection_check(object: Object, signal_name: String, target: Object, method: String) -> void:
	if not object.is_connected(signal_name, Callable(target, method)):
		object.connect(signal_name, Callable(target, method))

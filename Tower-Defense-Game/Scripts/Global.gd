extends Node

#variables to be integrated into nagis level manager
var playerHealth = 50
var playerGold = 100
var isPaused = false
var waveReady = true
var enemyCount = 0
var currentWave = 0
var prepWave = false

func reset_game_state() -> void:
    playerHealth = 1#50
    playerGold = 100
    isPaused = false
    waveReady = true
    enemyCount = 0
    currentWave = 0
    prepWave = false

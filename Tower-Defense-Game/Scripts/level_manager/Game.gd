extends Node2D

var isPaused = false

func _ready():
	$LevelManager.connect("level_complete", Callable(self, "_on_level_complete"))
	$LevelManager.connect("player_defeat", Callable(self, "_on_player_defeat"))
	$LevelManager.connect("game_complete", Callable(self, "_on_game_complete"))
	$LevelManager.start_level()

func _on_level_complete():
	print("Level completed!")


func _on_player_defeat():
	print("Game Over!")


func _on_game_complete():
	print("Congratulations! You've completed the game!")

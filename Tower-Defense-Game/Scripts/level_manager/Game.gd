extends Node2D

var isPaused = false

var tower_scene = preload("res://Scenes/tower1.tscn")

func _ready():
	$LevelManager.connect("level_complete", Callable(self, "_on_level_complete"))
	$LevelManager.connect("player_defeat", Callable(self, "_on_player_defeat"))
	$LevelManager.connect("game_complete", Callable(self, "_on_game_complete"))
	$LevelManager.connect("add_tower", Callable(self, "spawn_next_tower"))
	print("add tower signal connected")
	$LevelManager.start_level()
	$HUD.connect("buy_tower_requested", Callable(self, "spawn_next_tower"))



func _on_level_complete():
	print("Level completed!")


func _on_player_defeat():
	print("Game Over!")


func _on_game_complete():
	print("Congratulations! You've completed the game!")


func _on_buy_tower_pressed():
	Global.playerGold -= 5
	var tower_instance = tower_scene.instantiate()
	add_child(tower_instance)
	print("tower Added")

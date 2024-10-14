extends Node2D

var isPaused = false

var tower_scene = preload("res://Scenes/tower1.tscn")

@onready var input_manager: InputManager = $InputManager
@onready var stage: Stage = $Stage


func _ready():
	$LevelManager.connect("level_complete", Callable(self, "_on_level_complete"))
	$LevelManager.connect("player_defeat", Callable(self, "_on_player_defeat"))
	$LevelManager.connect("game_complete", Callable(self, "_on_game_complete"))
	$LevelManager.connect("add_tower", Callable(self, "spawn_next_tower"))
	print("add tower signal connected")
	$LevelManager.start_level()
	$HUD.connect("buy_tower_requested", Callable(input_manager,"start_tower_placement"))

	input_manager.stage = stage
	stage.input_manager = input_manager
	input_manager.connect("tower_placement_requested", Callable(stage, "handle_tower_placement_request"))
	input_manager.connect("tower_selected", Callable(stage, "_on_tower_selected"))


func _on_level_complete():
	print("Level completed!")


func _on_player_defeat():
	print("Game Over!")


func _on_game_complete():
	print("Congratulations! You've completed the game!")


func _on_buy_tower_pressed():
	print("Buy Tower button pressed")
	"""Global.playerGold -= 5
	var tower_instance = tower_scene.instantiate()
	add_child(tower_instance)
	print("tower Added")"""

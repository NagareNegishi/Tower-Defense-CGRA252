extends Node2D

var isPaused = false

var tower_scene = preload("res://Scenes/tower1.tscn")

@onready var input_manager: InputManager = $InputManager
@onready var level_manager: LevelManager = $LevelManager
@onready var stage: Stage = $Stage
@onready var hud: Control = $HUD
@onready var game_stats: GameStats = $GameStats


func _ready():
	setup_connections()
	level_manager.start_level()

# Connect signals
func setup_connections():
	input_manager.stage = stage
	stage.input_manager = input_manager
	input_manager.connect("tower_placement_requested", Callable(stage, "handle_tower_placement_request"))
	input_manager.connect("tower_selected", Callable(stage, "_on_tower_selected"))
	hud.connect("buy_tower_requested", Callable(input_manager, "start_tower_placement"))
	hud.connect("next_wave_requested", Callable(level_manager, "next_level"))
	level_manager.connect("level_complete", Callable(self, "_on_level_complete"))
	level_manager.connect("player_defeat", Callable(self, "_on_player_defeat"))
	level_manager.connect("game_complete", Callable(self, "_on_game_complete"))


func _on_level_complete():
	print("Level completed!")#################################
	hud.set_button(hud.next_wave_button, true)



func _on_player_defeat():
	print("Game Over!")##################################


func _on_game_complete():
	print("Congratulations! You've completed the game!")#############################


func _on_buy_tower_pressed():
	print("Buy Tower button pressed")
	Global.playerGold -= 5
	


func _on_pause_pressed():
	if !Global.isPaused:
		get_tree().paused = true
		Global.isPaused = true

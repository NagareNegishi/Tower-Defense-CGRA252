extends Node2D

var isPaused = false

var tower_scene = preload("res://Scenes/tower1.tscn")

@onready var input_manager: InputManager = $InputManager
@onready var level_manager: LevelManager = $LevelManager
@onready var stage: Stage = $Stage
@onready var hud: Control = $HUD
@onready var game_stats: GameStats = $GameStats
@onready var tower_manager: TowerManager = $TowerManager


func _ready():
	setup_connections()
	game_stats.score = 0
	game_stats.gold = 100
	game_stats.life = 1#50
	level_manager.start_level()


# Connect signals
func setup_connections():
	input_manager.stage = stage
	input_manager.game_stats = game_stats
	input_manager.tower_manager = tower_manager
	stage.input_manager = input_manager
	stage.game_stats = game_stats
	stage.tower_manager = tower_manager
	tower_manager.stage = stage
	tower_manager.game_stats = game_stats
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
	SceneManager.game_over()


func _on_game_complete():
	print("Congratulations! You've completed the game!")#############################
	SceneManager.victory()


func _on_pause_pressed():
	if !Global.isPaused:
		get_tree().paused = true
		Global.isPaused = true

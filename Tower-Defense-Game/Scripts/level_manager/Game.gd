extends Node2D

var isPaused = false

var Tower = preload("res://Scenes/tower1.tscn")
var tower_positions = [
    Vector2(500, 300),
    Vector2(500, 500),
    Vector2(500, 150)
]
var towers_spawned = 0

func _ready():
	$LevelManager.connect("level_complete", Callable(self, "_on_level_complete"))
	$LevelManager.connect("player_defeat", Callable(self, "_on_player_defeat"))
	$LevelManager.connect("game_complete", Callable(self, "_on_game_complete"))
	$LevelManager.connect("add_tower", Callable(self, "spawn_next_tower"))
	$LevelManager.start_level()



func _on_level_complete():
	print("Level completed!")


func _on_player_defeat():
	print("Game Over!")


func _on_game_complete():
	print("Congratulations! You've completed the game!")


func spawn_next_tower():
	if towers_spawned < tower_positions.size():
		spawn_tower_at_location(tower_positions[towers_spawned])
		towers_spawned += 1
		print("Tower spawned. Total towers: ", towers_spawned)
	else:
		print("Maximum number of towers reached!")


func spawn_tower_at_location(location: Vector2):
	var new_tower = Tower.instantiate()
	new_tower.position = location
	add_child(new_tower)


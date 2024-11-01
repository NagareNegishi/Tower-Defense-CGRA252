extends Node
class_name TowerManager

@export var game_stats: GameStats
@export var stage: Stage

# list of tower types and their costs
var tower_costs = {
	"type1": 100,
	"type2": 3000,
	"type3": 100,
	"type4": 300,
	"type5": 1200
}
# list of tower scenes
var tower_scenes = {
	"type1": preload("res://Scenes/Towers/tower1.tscn"),
	"type2": preload("res://Scenes/Towers/tower2.tscn"),
	"type3": preload("res://Scenes/Towers/tower3.tscn"),
	"type4": preload("res://Scenes/Towers/tower4.tscn"),
	"type5": preload("res://Scenes/Towers/tower5.tscn")
}

# check if the player can afford to build a tower
func can_build_tower(type: String) -> bool:
	return game_stats.gold >= tower_costs[type]

# get the cost of a tower
func get_tower_cost(type: String) -> int:
	return tower_costs[type]

# get the tower scene
func get_tower_scene(type: String) -> PackedScene:
	if tower_scenes.has(type):
		return tower_scenes[type]
	return tower_scenes["type1"]

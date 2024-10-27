extends Node
class_name TowerManager

@export var game_stats: GameStats
@export var stage: Stage

var tower_costs = {
    "basic": 100,
    #"advanced": 200,
}
var tower_scenes = {
    "basic": preload("res://Scenes/tower1.tscn"),
    #"advanced": preload("res://Scenes/tower2.tscn")
}

func can_build_tower(type: String) -> bool:
    return game_stats.gold >= tower_costs[type]

func get_tower_cost(type: String) -> int:
    return tower_costs[type]

func get_tower_scene(type: String) -> PackedScene:
    if tower_scenes.has(type):
        return tower_scenes[type]
    return tower_scenes["basic"] 
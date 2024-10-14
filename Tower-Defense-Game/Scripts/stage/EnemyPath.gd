class_name EnemyPath
extends Path2D

var path_follow: PathFollow2D
var slime_scene = preload("res://Scenes/Prototype/Temp_Slime.tscn")

func _ready():
	path_follow = $PathFollow2D
	path_follow.loop = false

func get_start_position() -> Vector2:
	return curve.get_point_position(0)

func get_end_position() -> Vector2:
	return curve.get_point_position(curve.point_count - 1)

func spawn_enemy(enemy_scene: PackedScene) -> Node2D:
	var enemy = enemy_scene.instantiate()
	path_follow.add_child(enemy)
	path_follow.progress_ratio = 0
	return enemy


func get_progress() -> float:
	return path_follow.progress_ratio

func set_progress(value: float):
	path_follow.progress_ratio = value

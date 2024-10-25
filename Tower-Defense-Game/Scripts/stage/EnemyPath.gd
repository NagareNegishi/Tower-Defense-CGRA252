class_name EnemyPath
extends Path2D

func spawn_enemy(enemy) -> Node2D:
	var new_path = PathFollow2D.new()
	add_child(new_path)
	new_path.loop = false
	new_path.progress_ratio = 0
	new_path.add_child(enemy)
	return enemy

func get_start_position() -> Vector2:
	return curve.get_point_position(0)

func get_end_position() -> Vector2:
	return curve.get_point_position(curve.point_count - 1)
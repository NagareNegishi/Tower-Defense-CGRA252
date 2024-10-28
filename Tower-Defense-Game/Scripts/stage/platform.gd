extends StaticBody2D
class_name Platform

var is_occupied = false
const EDGE_MARGIN: float = 10.0  # margin around the platform edge

func get_rect() -> Rect2:
	var size = $ColorRect.size * scale.abs()
	var pos = global_position - size / 2
	return Rect2(pos, size).abs()

func get_safe_rect() -> Rect2:
	var full_rect = get_rect()
	return full_rect.grow(-EDGE_MARGIN)

func contains_point(point: Vector2) -> bool:
	return get_safe_rect().has_point(point)

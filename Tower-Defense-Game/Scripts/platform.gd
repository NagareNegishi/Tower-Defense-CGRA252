extends StaticBody2D
class_name Platform

var is_occupied = false
# Called when the node enters the scene tree for the first time.
#func _ready():
	#modulate = Color(Color.MEDIUM_PURPLE, 0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ControlManager.is_dragging:
	# If dragging is occurring, change the color or size of the platform
		if ControlManager.is_dragging:
			modulate = Color(Color.REBECCA_PURPLE, 1)  # Highlight when dragging
		else:
			modulate = Color(Color.MEDIUM_PURPLE, 0.2)  # Reset color when not dragging

func occupy_platform():
	is_occupied = true
	modulate = Color(Color.DARK_SLATE_BLUE, 1)




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

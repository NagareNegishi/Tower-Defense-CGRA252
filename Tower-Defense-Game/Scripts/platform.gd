extends StaticBody2D

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

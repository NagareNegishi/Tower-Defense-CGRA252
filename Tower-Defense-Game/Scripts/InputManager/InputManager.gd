extends Node
class_name InputManager

signal tower_placement_requested(position)
signal tower_selected(tower)
signal ui_button_clicked(button_name)

var is_placing_tower: bool = false
var tower_image: Sprite2D
@onready var tower_preview: Sprite2D = $TowerPreview
var stage: Stage

func _ready():
	tower_preview.visible = false
	set_process_input(true)
	set_process(true)

func _process(_delta):
	if is_placing_tower:
		_update_preview_position()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_handle_left_click()


func _handle_left_click():
	var mouse_position = get_viewport().get_mouse_position()
	
	if is_placing_tower:
		emit_signal("tower_placement_requested", mouse_position)

	else:
		var clicked_tower = _get_tower_at_position(mouse_position)
		emit_signal("tower_selected", clicked_tower)

func start_tower_placement():
	is_placing_tower = true
	tower_preview.visible = true
	_update_preview_position()

func end_tower_placement():
	is_placing_tower = false
	tower_preview.visible = false

func _update_preview_position():
	if is_placing_tower:
		tower_preview.global_position = get_viewport().get_mouse_position()
		if stage:
			tower_preview.modulate = Color.GREEN if stage.is_valid_tower_position(tower_preview.global_position) else Color.RED

func handle_placement_result(success: bool):
	if success:
		end_tower_placement()
	else:
		print("Tower placement failed. Try another location.")

func _get_tower_at_position(position: Vector2) -> Tower:
	for tower in stage.towers:
		if tower.get_node("Selection").get_global_rect().has_point(position):
			return tower
	return null

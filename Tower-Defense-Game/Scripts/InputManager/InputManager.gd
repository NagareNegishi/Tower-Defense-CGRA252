extends Node
class_name InputManager

signal tower_placement_requested(position)
signal tower_selected(tower)
signal ui_button_clicked(button_name)

var is_placing_tower: bool = false
var tower_image: Sprite2D
@onready var tower_preview: Sprite2D = $CanvasLayer/TowerPreview
@onready var upgrade_popup: UpgradePopup = $CanvasLayer/UpgradePopup
@export var game_stats: GameStats
@export var tower_manager: TowerManager
var stage: Stage
var current_tower_type: String = "type1"
var selected_tower: Tower = null

# set the tower image
func _ready():
	tower_preview.visible = false
	upgrade_popup.upgrade_confirmed.connect(_on_upgrade_confirmed)
	upgrade_popup.upgrade_cancelled.connect(_on_upgrade_cancelled)
	upgrade_popup.hide()

# process input
func _process(_delta):
	if is_placing_tower:
		_update_preview_position()

# handle input
func _input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton
			and event.button_index == MOUSE_BUTTON_LEFT
			and event.pressed):
		return
	var pos = event.position
	if upgrade_popup.visible and upgrade_popup.get_global_rect().has_point(pos):
		return
	_handle_left_click()

# handle left click
func _handle_left_click() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	if is_placing_tower:
		emit_signal("tower_placement_requested", mouse_position)
	else:
		var clicked_tower = _get_tower_at_position(mouse_position)
		if clicked_tower:
			select_tower(clicked_tower)
		else:
			deselect_current_tower()

# start tower placement
func start_tower_placement(tower_type: String):
	if tower_manager.can_build_tower(tower_type):
		current_tower_type = tower_type
		is_placing_tower = true
		tower_preview.visible = true
		_update_preview_position()
	else:
		print("Not enough gold to build tower")

# update preview position
func _update_preview_position():
	if is_placing_tower:
		tower_preview.global_position = get_viewport().get_mouse_position()
		if stage:
			tower_preview.modulate = Color.GREEN if stage.is_valid_tower_position(tower_preview.global_position) else Color.RED

# end tower placement
func end_tower_placement():
	is_placing_tower = false
	tower_preview.visible = false

# handle tower placement result
func handle_placement_result(success: bool):
	if success:
		end_tower_placement()
	else:
		print("Tower placement failed. Try another location.")

# get tower at position
func _get_tower_at_position(position: Vector2) -> Tower:
	for tower in stage.towers:
		if tower.get_node("Selection").get_global_rect().has_point(position):
			return tower
	return null

# Handle upgrade confirmations
func _on_upgrade_confirmed(tower: Tower, choice: int) -> void:
	var cost: int
	match choice:
		1:
			cost = tower.upgrade_price1
		2:
			cost = tower.upgrade_price2
	if game_stats.gold >= cost and tower.current_level < tower.max_level:
		game_stats.gold -= cost
		Global.playerGold = game_stats.gold
		tower.level_up(choice)
		upgrade_popup.update_button_states()

# Handle upgrade cancellations
func _on_upgrade_cancelled() -> void:
	deselect_current_tower()

# Select a tower
func select_tower(tower: Tower) -> void:
	deselect_current_tower()
	selected_tower = tower
	selected_tower.select_tower()
	upgrade_popup.setup(tower)
	upgrade_popup.show()
	emit_signal("tower_selected", tower)

# Deselect the current tower
func deselect_current_tower() -> void:
	if selected_tower:
		selected_tower.deselect_tower()
		selected_tower = null
		upgrade_popup.hide()

extends Control
class_name UpgradePopup

signal upgrade_confirmed(tower: Tower, choice: int)
signal upgrade_cancelled

@onready var choice1_button: Button = $Choice1
@onready var choice2_button: Button = $Choice2
@onready var cancel_button: Button = $Cancel

var current_tower: Tower
const OFFSET := Vector2(50, -100)

# call the setup function to initialize the popup
func _ready() -> void:
	set_process(false)

# check if the player can afford the upgrade while the popup is open
func _process(_delta: float) -> void:
	update_button_states()

# setup the popup
func setup(tower: Tower) -> void:
	current_tower = tower
	update_button_states()
	update_position()
	set_process(true)

# check if the player can afford the upgrades
func update_button_states() -> void:
	if not current_tower:
		return
	if current_tower.current_level >= current_tower.max_level:
		choice1_button.disabled = true
		choice2_button.disabled = true
		return
	can_afford(choice1_button, current_tower.upgrade_price1)
	can_afford(choice2_button, current_tower.upgrade_price2)

# check if the player can afford the upgrade
func can_afford(button: Button, price: int) -> void:
	button.disabled = Global.playerGold < price

# update the position of the popup
func update_position() -> void:
	if not current_tower:
		return
	var pos = current_tower.global_position + OFFSET
	global_position = safe_position(pos)

# keep the popup within the viewport
func safe_position(pos: Vector2) -> Vector2:
	var viewport_size = get_viewport_rect().size
	return Vector2(
		clamp(pos.x, 0, viewport_size.x - size.x),
		clamp(pos.y, 0, viewport_size.y - size.y)
	)

# send the upgrade signal and close the popup
func _on_choice1_pressed() -> void:
	upgrade_confirmed.emit(current_tower, 1)
	close_popup()

# send the upgrade signal and close the popup
func _on_choice2_pressed() -> void:
	upgrade_confirmed.emit(current_tower, 2)
	close_popup()

# close the popup
func _on_cancel_pressed() -> void:
	upgrade_cancelled.emit()
	close_popup()

# hide the popup and stop processing
func close_popup() -> void:
	super.hide()
	set_process(false)

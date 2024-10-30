extends Control
class_name UpgradePopup

signal upgrade_confirmed(tower: Tower, choice: int)
signal tower_sold(tower: Tower)

@onready var choice1_button: Button = $Choice1
@onready var choice2_button: Button = $Choice2
@onready var sell_button: Button = $Sell

var current_tower: Tower
const OFFSET := Vector2(50, -100)
const COLORS = {
	"default": Color.GREEN,
	"cant_afford": Color(1, 0.8, 0.8),
	"max_level": Color.YELLOW,
	"warning": Color.RED
}

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
	update_sell_button()
	set_process(true)

# check if the player can afford the upgrades
func update_button_states() -> void:
	if not current_tower:
		return
	if current_tower.current_level >= current_tower.max_level:
		set_max_level(choice1_button)
		set_max_level(choice2_button)
		return
	update_button(
		choice1_button,
		current_tower.option1_text,
		current_tower.upgrade_price1,
		Global.playerGold >= current_tower.upgrade_price1
	)
	update_button(
		choice2_button,
		current_tower.option2_text,
		current_tower.upgrade_price2,
		Global.playerGold >= current_tower.upgrade_price2
	)

# set the button to max level
func set_max_level(button: Button) -> void:
	button.text = "Max Level"
	button.modulate = COLORS.max_level
	button.disabled = true

# update the button text and color
func update_button(button: Button, text: String, price: int, can_afford: bool) -> void:
	button.text = "%s (%d G)" % [text, price]
	button.modulate = COLORS.default if can_afford else COLORS.cant_afford
	button.disabled = !can_afford

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

# update the sell button text
func update_sell_button() -> void:
	if not current_tower:
		return
	var sell_price = current_tower.get_sell_price()
	sell_button.text = "Sell (%d G)" % sell_price
	sell_button.modulate = COLORS.warning

# send the upgrade signal and close the popup
func _on_choice1_pressed() -> void:
	upgrade_confirmed.emit(current_tower, 1)
	close_popup()

# send the upgrade signal and close the popup
func _on_choice2_pressed() -> void:
	upgrade_confirmed.emit(current_tower, 2)
	close_popup()

# sell the tower and close the popup
func _on_sell_pressed() -> void:
	tower_sold.emit(current_tower)
	close_popup()

# hide the popup and stop processing
func close_popup() -> void:
	super.hide()
	set_process(false)

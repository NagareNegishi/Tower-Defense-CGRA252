extends Control
class_name HUD

signal next_wave_requested
signal buy_tower_requested(tower_type: String)

@onready var next_wave_button = $"CanvasLayer/Next Wave"
@onready var buy_tower_button = $"CanvasLayer/Buy Tower"
@onready var buy_tower2_button = $"CanvasLayer/Buy Tower2"
@onready var buy_tower3_button = $"CanvasLayer/Buy Tower3"
@onready var buy_tower4_button = $"CanvasLayer/Buy Tower4"
@onready var health_label = $CanvasLayer/Health
@onready var money_label = $CanvasLayer/Money

# Check buttons and connect signals
func _ready():
	if next_wave_button:
		next_wave_button.pressed.connect(_on_next_wave_pressed)
		set_button(next_wave_button, false)
		next_wave_button.visible = false
	else:
		push_error("Next Wave button not found!")
	if buy_tower_button:
		buy_tower_button.pressed.connect(_on_buy_tower_pressed)
	else:
		push_error("Buy Tower button not found!")
	if buy_tower2_button:
		buy_tower2_button.pressed.connect(_on_buy_tower_2_pressed)
	else:
		push_error("Buy Tower2 button not found!")
	if buy_tower3_button:
		buy_tower3_button.pressed.connect(_on_buy_tower_3_pressed)
	else:
		push_error("Buy Tower3 button not found!")
	if buy_tower4_button:
		buy_tower4_button.pressed.connect(_on_buy_tower_4_pressed)
	else:
		push_error("Buy Tower4 button not found!")
	setup_labels()


#dynaically change player HP/gold and play icon animations
func _process(_delta):
	update_labels()
	$CanvasLayer/Coin.play("Shine")
	$CanvasLayer/Heart.play("Shine")

# send request to level_manager
func _on_next_wave_pressed():
	next_wave_requested.emit()
	set_button(next_wave_button, false)
	next_wave_button.visible = false

# send request to input_manager
func _on_buy_tower_pressed():
	buy_tower_requested.emit("type1")

# send request to input_manager
func _on_buy_tower_2_pressed():
	buy_tower_requested.emit("type2")

# send request to input_manager
func _on_buy_tower_3_pressed():
	buy_tower_requested.emit("type3")
# send request to input_manager
func _on_buy_tower_4_pressed():
	buy_tower_requested.emit("type4")

# enable/disable button
func set_button(button: Button, enabled: bool) -> void:
	if button:
		button.disabled = !enabled
		if enabled:
			button.mouse_filter = Control.MOUSE_FILTER_STOP
			button.visible = true
		else:
			button.mouse_filter = Control.MOUSE_FILTER_IGNORE

# setup labels
func setup_labels():
	if health_label:
		health_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		health_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	if money_label:
		money_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		money_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

# update labels
func update_labels():
	if health_label:
		health_label.text = str(Global.playerHealth)
	if money_label:
		money_label.text = str(Global.playerGold)

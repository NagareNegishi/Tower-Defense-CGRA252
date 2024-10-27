extends Control
class_name HUD

signal next_wave_requested
signal buy_tower_requested

@onready var next_wave_button = $"CanvasLayer/Next Wave"
@onready var buy_tower_button = $"CanvasLayer/Buy Tower"

# Check if buttons are found and disable them
func _ready():
	if next_wave_button:
		next_wave_button.pressed.connect(_on_next_wave_pressed)
		set_button(next_wave_button, false)
		next_wave_button.visible = false

	else:
		push_error("Next Wave button not found!")
	if buy_tower_button:
		buy_tower_button.pressed.connect(_on_buy_tower_pressed)
		#set_button(buy_tower_button, false)
	else:
		push_error("Buy Tower button not found!")

#dynaically change player HP/gold and play icon animations
func _process(_delta):
	$CanvasLayer/Health.text = str(Global.playerHealth)
	$CanvasLayer/Money.text = str(Global.playerGold)
	$CanvasLayer/Coin.play("Shine")
	$CanvasLayer/Heart.play("Shine")

func _on_next_wave_pressed():
	print("Next Wave button pressed")################################
	next_wave_requested.emit()

func _on_buy_tower_pressed():
	print("Buy Tower button pressed")############################### we need price for tower
	buy_tower_requested.emit()

# enable/disable button
func set_button(button: Button, enabled: bool) -> void:
	if button:
		button.disabled = !enabled
		if enabled:
			button.mouse_filter = Control.MOUSE_FILTER_STOP
			button.visible = true
		else:
			button.mouse_filter = Control.MOUSE_FILTER_IGNORE

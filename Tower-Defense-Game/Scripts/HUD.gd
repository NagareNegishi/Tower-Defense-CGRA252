extends Control
class_name HUD

signal next_wave_requested
signal buy_tower_requested

@onready var next_wave_button = $"CanvasLayer/Next Wave"
@onready var buy_tower_button = $"CanvasLayer/Buy Tower"

func _ready():
	print("HUD _ready called")
	print("next_wave_button: ", next_wave_button)
	if next_wave_button:
		print("Button class: ", next_wave_button.get_class())
		next_wave_button.pressed.connect(_on_next_wave_pressed)
	else:
		push_error("Next Wave button not found!")
	
	if buy_tower_button:
		print("Button class: ", buy_tower_button.get_class())
		buy_tower_button.pressed.connect(_on_buy_tower_pressed)
	else:
		push_error("Buy Tower button not found!")


func _on_next_wave_pressed():
	print("Next Wave button pressed")
	next_wave_requested.emit()

func _on_buy_tower_pressed():
	print("Buy Tower button pressed")
	buy_tower_requested.emit()


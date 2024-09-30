extends Control
class_name HUD

signal next_wave_requested

@onready var next_wave_button = $"CanvasLayer/Next Wave"

func _ready():
    print("HUD _ready called")
    print("next_wave_button: ", next_wave_button)
    if next_wave_button:
        print("Button class: ", next_wave_button.get_class())
        next_wave_button.pressed.connect(_on_next_wave_pressed)
    else:
        push_error("Next Wave button not found!")


func _on_next_wave_pressed():
    print("Next Wave button pressed")
    next_wave_requested.emit()


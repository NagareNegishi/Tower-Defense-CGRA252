extends Button
class_name CustomButton

signal click_end()

@onready var sound_hover: AudioStreamPlayer = $Sound_Hover
@onready var sound_click: AudioStreamPlayer = $Sound_Click
@export var custom_text: String = ""

# setup the button and connect the signals
func _ready() -> void:
	if custom_text != "":
		text = custom_text
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)
	sound_click.finished.connect(_on_sound_click_finished)

# play the hover sound
func _on_mouse_entered():
	sound_hover.play()

# play the click sound
func _on_pressed():
	sound_click.play()

# emit the click_end signal when the click sound is finished
func _on_sound_click_finished():
	click_end.emit()

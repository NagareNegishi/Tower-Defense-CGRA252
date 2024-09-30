extends Button

# Define a custom signal
signal start_wave_signal

func _ready():
	# Connect the button's pressed signal to emit the custom signal
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	# Emit the custom signal when the button is pressed
	emit_signal("start_wave_signal")

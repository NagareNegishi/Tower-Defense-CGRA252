extends Node2D

#dymanic variables for valume control
@export
var bus_name: String
var bus_index: int


func _ready():
		#set bus index for music
	bus_index = AudioServer.get_bus_index("Master")
	#connect volume slider 
	$Control/HSlider.value_changed.connect(_on_h_slider_value_changed)

#open settings menu
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Prototype/Main_Menu.tscn")


#change volume accoring to slider position
func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

#mute for music
func _on_check_button_toggled(_toggled_on):
	AudioServer.set_bus_mute(bus_index, not AudioServer.is_bus_mute(bus_index))

#show menu while paused
func _on_pause_pressed():
	self.show()

#unpause and hide setting menu
func _on_button_pressed():
	self.hide()
	Global.isPaused = false
	get_tree().paused = false

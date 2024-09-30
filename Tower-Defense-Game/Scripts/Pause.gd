extends Button

#check is not paused and pause if valid
func _on_pressed():
	if !Global.isPaused:
		get_tree().paused = true
		Global.isPaused = true



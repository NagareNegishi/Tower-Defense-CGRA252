extends Button

func _on_pressed():
	if !Global.isPaused:
		get_tree().paused = true
		Global.isPaused = true



extends Button

#check if game is paused and if valid play
func _on_pressed():
	if Global.isPaused:
		get_tree().paused = false
		Global.isPaused = false


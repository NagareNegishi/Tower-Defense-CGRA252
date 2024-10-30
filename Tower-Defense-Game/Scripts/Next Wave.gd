extends Button

#diable use of button during wave process
func _process(_delta):
	if Global.enemyCount > 0:
		disabled = true
	else:
		disabled = false

func _on_pressed():
	#ensure wave is over
	if Global.enemyCount == 0:
		Global.waveReady = true

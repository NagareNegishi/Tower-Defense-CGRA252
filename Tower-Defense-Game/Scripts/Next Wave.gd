extends Button

#diable use of button during wave process
func _process(delta):
	if Global.enemyCount > 0:
		disabled = true
	else:
		disabled = false

func _on_pressed():
	#ensure wave is over
	if Global.enemyCount == 0:
		#increment wave count
		Global.currentWave += 1
		#ready wave for spawner
		Global.waveReady = true

extends Button

func _process(delta):
	if Global.playerGold >= 100:
		disabled = false

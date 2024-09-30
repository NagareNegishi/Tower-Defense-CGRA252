extends Button

func _process(delta):
	if Global.playerGold >= 5:
		disabled = false

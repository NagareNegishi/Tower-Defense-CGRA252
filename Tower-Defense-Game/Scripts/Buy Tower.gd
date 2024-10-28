extends Button

func _process(_delta):
	if Global.playerGold >= 100:
		disabled = false

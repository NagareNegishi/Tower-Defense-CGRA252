extends TextEdit

#dyanamically change player gold
func _process(delta):
	text = str(Global.playerGold)
	

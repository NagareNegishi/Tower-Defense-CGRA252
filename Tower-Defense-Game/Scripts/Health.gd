extends TextEdit

#dynaically change player Hp
func _process(delta):
	text = str(Global.playerHealth)


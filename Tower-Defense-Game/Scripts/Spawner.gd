extends Node2D

@onready var path = preload("res://Scenes/Stage1.tscn")
var enemyCount = 0

func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)
	
	enemyCount += 1
	
	if enemyCount >= 10:
		$Timer.stop()


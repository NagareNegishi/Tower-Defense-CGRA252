extends StaticBody2D


var Bullet = preload("res://Scenes/tower_1_arrow.tscn")
var bulletDamage = 100
var pathName
var currTargets = []
var curr
@onready var sprite = get_node("towerSprite")


func _on_tower_body_entered(body):
	if "Slime" in body.name:
		print("a")
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()

		for i in currTargets:
			if "Slime" in i.name:
				tempArray.append(i)
		
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_parent()
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_parent()
		curr = currTarget
		
		pathName = currTarget.get_parent().name
		var tempBullet = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		get_node("arrowContainer").add_child(tempBullet)
		tempBullet.global_position = $Aim.global_position
		
func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()
	

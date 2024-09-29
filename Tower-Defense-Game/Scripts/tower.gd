extends StaticBody2D


var Bullet = preload("res://Scenes/tower_1_arrow.tscn")
var bulletDamage = 100
var pathName
var currTargets = []
var curr
@onready var sprite = get_node("towerSprite")
var current_level = 0
var tower_levels = [
	{"damage": 100, "sprite": "res://Sprites/towerlvl1.png"},
	{"damage": 150, "sprite": "res://Sprites/towerlvl2.png"},
	{"damage": 200, "sprite": "res://Sprites/towerlvl3.png"},
	{"damage": 300, "sprite": "res://Sprites/towerlvl4.png"},
	{"damage": 500, "sprite": "res://Sprites/towerlvl5.png"}
]

func level_up():
	if current_level < tower_levels.size() - 1:
		current_level += 1
		update_tower_properties()
		print("Tower leveled up to level ", current_level + 1)
	else:
		print("Tower is already at max level.")

func update_tower_properties():
	bulletDamage = tower_levels[current_level]["damage"]
	sprite.texture = load(tower_levels[current_level]["sprite"])
	
func _on_tower_body_entered(body):
	if "Slime" in body.name or "Bee" in body.name or "Wolf" in body.name or "Goblin" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()

		for i in currTargets:
			if "Slime" in i.name or "Bee" in i.name or "Wolf" in i.name or "Goblin" in i.name:
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
	

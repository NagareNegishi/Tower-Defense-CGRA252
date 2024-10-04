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

var draggable = false
var is_inside_dropable = false
var body_ref
var offset : Vector2
var initialPos : Vector2

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
				currTarget = i
				
			else:
				if i.get_parent().get_progress() > currTarget.get_parent().get_progress():
					currTarget = i
		
		curr = currTarget
		
		pathName = currTarget.get_parent().name
		
		
		var tempBullet = Bullet.instantiate()
		tempBullet.target = currTarget
		tempBullet.bulletDamage = bulletDamage
		get_node("arrowContainer").add_child(tempBullet)
		tempBullet.global_position = global_position
		
func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()
	
			
func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			ControlManager.is_dragging = true
			
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			ControlManager.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
	

func _on_area_2d_mouse_entered():
	if not ControlManager.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	if not ControlManager.is_dragging:
		draggable = false
		scale = Vector2(1, 1)


func _on_area_2d_body_entered(body):
	if body.is_in_group("drop"):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("drop"):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)


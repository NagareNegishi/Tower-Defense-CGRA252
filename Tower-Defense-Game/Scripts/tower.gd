extends StaticBody2D
class_name Tower


var Bullet = preload("res://Scenes/tower_1_arrow.tscn")
var bulletDamage = 100
var pathName
var currTargets = []
var curr
var currTarget
var fire_rate = 1.0
var fire_timer = 0.0

var is_selected = false

@onready var sprite = get_node("towerSprite")
@onready var collision_shape = $CollisionShape2D


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


func _ready_():
	fire_timer = fire_rate
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and not draggable:
			var collision_shape = $CollisionShape2D
			var mouse_pos = get_global_mouse_position()
			
			# Check if the mouse is over the tower using the collision shape
			if collision_shape.shape and collision_shape.shape.overlaps_point(to_local(mouse_pos)):
				select_tower()
			else:
				deselect_tower()
				get_node("/root/HUD").deselect_tower()

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
	# Only target enemies in the "enemy" group
	if body.is_in_group("enemy") and body != self:
		currTargets.append(body)
		if currTarget == null:
			currTarget = body
			
		currTarget = null
		
		for i in currTargets:
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
	if body in currTargets:
		currTargets.erase(body)
	
	if body == currTarget:
		currTarget = null
	#currTargets = get_node("Tower").get_overlapping_bodies()
	
			
func _process(delta):
	
	
	fire_timer -= delta
	
	if currTarget and currTarget.health > 0:
		if fire_timer <= 0.0:
			_fire()
			fire_timer = fire_rate
			
	else:
		#currTargets.erase(currTarget)
		currTarget = _new_target()

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
			if is_inside_dropable and body_ref.is_occupied == false:
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
				body_ref.occupy_platform()
				draggable = false
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
		body_ref = body
		if get_parent() is Stage:
			emit_signal("tower_placed", self)

func _fire():
	if currTarget:
		var tempBullet = Bullet.instantiate()
		tempBullet.target = currTarget
		tempBullet.bulletDamage = bulletDamage
		get_node("arrowContainer").add_child(tempBullet)
		tempBullet.global_position = global_position
		

func _new_target():
	if currTargets.size() > 0:
		return currTargets[0]
	return null
	

func select_tower():
	is_selected = true
	print("Tower selected")
	# You can add visual feedback like changing the tower's appearance here

# Function to deselect the tower
func deselect_tower():
	is_selected = false
	print("Tower deselected")
	# Reset the tower's appearance if needed

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

@onready var sprite = $towerSprite
@onready var tower_area = $Tower
@onready var detection_area = $Tower/DetectionArea
@onready var selection_rect = $Selection
@onready var upgrade_button = $UpgradeButton
var detection_color = Color(1, 1, 1, 0.4)  # White with 20% opacity
var detection_scale = 15.0

signal upgrade_requested(tower)

var current_level = 1
var tower_levels = [
	{"damage": 100, "sprite": "res://Sprites/towerlvl1.png"},  # we can remove this sprite refarence it is not there anyway
	{"damage": 150, "sprite": "res://Sprites/towerlvl2.png"},
	{"damage": 200, "sprite": "res://Sprites/towerlvl3.png"},
	{"damage": 300, "sprite": "res://Sprites/towerlvl4.png"},
	{"damage": 500, "sprite": "res://Sprites/towerlvl5.png"}
]

func _ready_():
	fire_timer = fire_rate
	scale_detection_area(detection_scale)
	selection_rect.visible = false
	upgrade_button.hide()


func _process(delta):
	tower_area.queue_redraw()

	fire_timer -= delta
	if currTarget and currTarget.health > 0:
		if fire_timer <= 0.0:
			_fire()
			fire_timer = fire_rate
			
	else:
		#currTargets.erase(currTarget)
		currTarget = _new_target()


func level_up():
	if current_level < tower_levels.size() - 1:
		current_level += 1
		update_tower_properties()
		print("Tower leveled up to level ", current_level + 1)
	else:
		print("Tower is already at max level.")

func update_tower_properties():
	bulletDamage = tower_levels[current_level]["damage"]
	#sprite.texture = load(tower_levels[current_level]["sprite"])
	sprite.play("towerlvl" + str(current_level))
	
	
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
	









# Function to select the tower
func select_tower():
	is_selected = true
	selection_rect.visible = true
	upgrade_button.show()
	tower_area.queue_redraw()

# Function to deselect the tower
func deselect_tower():
	is_selected = false
	selection_rect.visible = false
	upgrade_button.hide()
	tower_area.queue_redraw()

# Function to draw the detection area of the tower
func _on_tower_draw():
	if is_selected:
		var shape = detection_area.shape as CircleShape2D
		if shape:
			tower_area.draw_circle(Vector2.ZERO, shape.radius * detection_scale , detection_color)

# Function to scale the detection area of the tower
func scale_detection_area(new_scale: float):
	detection_scale = new_scale
	tower_area.scale *= detection_scale
	detection_area.scale *= detection_scale

# Function to handle the input event for the upgrade button
func _on_upgrade_button_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		print("Upgrade button pressed")
		level_up()


extends StaticBody2D
class_name Tower

signal upgrade_requested(tower)

@onready var sprite = $towerSprite
@onready var tower_area = $TowerArea
@onready var detection_area = $TowerArea/DetectionArea
@onready var selection_rect = $Selection
@onready var arrow_container = $arrowContainer
var Bullet = preload("res://Scenes/tower_1_arrow.tscn")
var bullet_damage = 100
var pathName
var curr
# fields related to targeting
var current_targets: Array[EnemyBase] = []
var current_target: EnemyBase = null
var fire_rate: float = 1.0
var fire_timer: float = 0.0
# fields related to selection and detection area
var is_selected = false
var detection_color = Color(1, 1, 1, 0.4)  # White with 20% opacity
var detection_scale = 5.0
# fields related to tower properties
var price: int = 100
var upgrade_price1: int = 50
var upgrade_price2: int = 50
var option1 := [5, 10, 15, 20, 25] # attack range
var option2 := [1.0, 0.9, 0.8, 0.7, 0.6] # fire rate
var option_count1 := 0
var option_count2 := 0
var current_level = 1
const MAX_LEVEL: int = 5

# Initialize the tower properties
func _ready():
	fire_timer = fire_rate
	selection_rect.visible = false
	update_tower(3)

# Update the tower properties based on the current level
func update_tower(choice: int) -> void:
	match choice:
		1:
			option_count1 += 1
			upgrade_price1 += 50
			scale_detection_area(option1[option_count1])
		2:
			option_count2 += 1
			upgrade_price2 += 50
			fire_rate = option2[option_count2]
		3:
			scale_detection_area(option1[option_count1])
			fire_rate = option2[option_count2]
	sprite.play("towerlvl" + str(current_level))

# keep track of the current target
func _process(delta):
	tower_area.queue_redraw()
	targeting(delta)

# Validate the target
func is_valid_target(target: EnemyBase) -> bool:
	return target != null and is_instance_valid(target) and target.health > 0

# Handle the targeting of the tower
func targeting(delta: float) -> void:
	fire_timer -= delta
	# if the current target is invalid, acquire a new target
	if not is_valid_target(current_target):
		current_target = find_target()
		return
	if fire_timer <= 0.0:
		fire()
		fire_timer = fire_rate

# Find the target from the list of enemies
func find_target() -> EnemyBase:
	# filter out invalid targets
	current_targets = current_targets.filter(is_valid_target)
	if current_targets.is_empty():
		return null
		
	# Get the enemy that has progressed the furthest along the path
	return advanced_enemy()

# find the most advanced enemy
func advanced_enemy() -> EnemyBase:
	var target: EnemyBase = current_targets[0]
	var progress: float = target.get_parent().get_progress()
	for enemy in current_targets:
		var candidate: float = enemy.get_parent().get_progress()
		if candidate > progress:
			progress = candidate
			target = enemy
	return target

# Fire the bullet at the target
func fire() -> void:
	if not current_target:
		return
	var bullet = Bullet.instantiate()
	bullet.target = current_target
	bullet.bullet_damage = bullet_damage
	arrow_container.add_child(bullet)
	bullet.global_position = global_position

# Handle the enemy entering the tower's detection area
func _on_tower_body_entered(body: Node2D) -> void:
	if not body is EnemyBase:
		return
	current_targets.append(body)
	if not current_target:
		current_target = body

# Handle the enemy exiting the tower's detection area
func _on_tower_body_exited(body: Node2D) -> void:
	if not body is EnemyBase:
		return
	current_targets.erase(body)
	if body == current_target:
		current_target = find_target()

# level up the tower
func level_up(choice: int) -> void:
	if current_level >= MAX_LEVEL:
		return
	current_level += 1
	update_tower(choice)

# Function to select the tower
func select_tower():
	is_selected = true
	selection_rect.visible = true

# Function to deselect the tower
func deselect_tower():
	is_selected = false
	selection_rect.visible = false

# Function to draw the detection area of the tower
func _on_tower_draw():
	if is_selected:
		var shape = detection_area.shape as CircleShape2D
		if shape:
			var radius = shape.radius * detection_area.scale.x
			tower_area.draw_circle(Vector2.ZERO, radius, detection_color)

# Function to scale the detection area of the tower
func scale_detection_area(new_scale: float):
	detection_scale = new_scale
	detection_area.scale = Vector2(detection_scale, detection_scale)


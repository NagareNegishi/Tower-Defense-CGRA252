extends Tower
class_name Tower3

# Tower3-specific settings
var can_fire: bool = true
var tower_fire_rate: float = 5.0  # Starting tick rate
var damage: int = 100  # Damage applied per tick

# Override _ready for set up
func _ready():
	super._ready()
	print("Detection area node in Tower3 is:", detection_area) 
	if detection_area != null:
		detection_area.disabled = false
	else:
		print("detection_area is null or inaccessible in Tower3!")
	scale_detection_area(10)  #
	_start_tick_damage()

# Start the tick damage loop
func _start_tick_damage() -> void:
	if not can_fire:
		return
	can_fire = false
	apply_area_damage()
	await get_tree().create_timer(tower_fire_rate).timeout
	can_fire = true
	_start_tick_damage()  # Recursively call to keep applying tick damage

var flash_color = Color(1, 0, 0, 0.6)
var original_color = Color(1, 1, 1, 0.4)

func apply_area_damage():
	# Temporarily show the detection area flash
	var was_selected = is_selected
	is_selected = true
	detection_color = flash_color
	tower_area.queue_redraw()
	await get_tree().create_timer(0.1).timeout
	detection_color = original_color
	is_selected = was_selected
	tower_area.queue_redraw()
	
	# Apply damage to targets
	var targets = get_targets_in_range()
	for target in targets:
		if is_instance_valid(target):
			target.take_damage(damage)

func get_targets_in_range() -> Array:
	var space_state = get_world_2d().direct_space_state
	var targets = []
	var collision_shape = detection_area.shape as CircleShape2D
	
	if not collision_shape:
		print("Detection area shape is null!")
		return []

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = collision_shape
	query.transform = detection_area.global_transform
	query.collision_mask = 1 << 0
	
	var overlaps = space_state.intersect_shape(query, 32)
	for overlap in overlaps:
		var body = overlap.collider
		if body != self and body is EnemyBase:
			targets.append(body)
	return targets

# Function to scale the detection area
func scale_detection_area(new_radius: float):
	detection_scale = new_radius
	if detection_area and detection_area.shape is CircleShape2D:
		var circle_shape = detection_area.shape as CircleShape2D
		circle_shape.radius = new_radius  # Set radius directly
	tower_area.queue_redraw()

func update_tower(choice: int) -> void:
	print()
	match choice:
		1:  # Upgrade range
			option_count1 += 1
			upgrade_price1 += 50 * option_count1
			total_value += upgrade_price1
			detection_area.shape.radius += 5
		2:  # Upgrade fire rate
			option_count2 += 1
			upgrade_price2 += 50 * option_count2
			total_value += upgrade_price2
			tower_fire_rate = max(0.5, tower_fire_rate - 0.5 * option_count2) 
	if choice == 2:
		_start_tick_damage()  # Restart tick damage loop with updated fire rate
# Function to select the tower
func select_tower():
	is_selected = true
	tower_area.queue_redraw()
	if selection_rect:
		selection_rect.visible = true


func deselect_tower():
	is_selected = false
	if selection_rect:
		selection_rect.visible = false
	tower_area.queue_redraw()

# Drawing function for the tower area
func _on_tower_area_draw():
	if is_selected:
		var shape = detection_area.shape as CircleShape2D
		if shape:
			var radius = shape.radius * detection_area.scale.x
			tower_area.draw_circle(Vector2.ZERO, radius, detection_color)

extends Tower
class_name Tower4

var MagicBalls = preload("res://Scenes/Towers/FlyingBalls.tscn")
var can_fire: bool = true

# set the tower parameters
func _ready():
	super._ready()
	fire_rate = 2
	scale_detection_area(10)
	price = 2000
	upgrade_price1 = 400
	upgrade_price2 = 400
	option1 = [10, 15] # attack range
	option2 = [1.5, 1] # fire rate
	current_level = 1
	max_level = 2

# override the fire function
func fire() -> void:
	if not can_fire or not current_target or not is_instance_valid(current_target):
		return
	can_fire = false
	var ball = MagicBalls.instantiate()
	get_parent().add_child(ball)
	ball.global_position = current_target.global_position
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true

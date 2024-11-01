extends Tower
class_name Tower5
## Tower2 will fire a thunderbolt at the enemy

var b = preload("res://Scenes/Towers/slimeball.tscn")
var can_fire: bool = true

# set the tower parameters
func _ready():
	super._ready()
	fire_rate = 2.5
	scale_detection_area(10)
	price = 1200
	upgrade_price1 = 800
	upgrade_price2 = 1200
	option1 = [10, 15] # attack range
	option2 = [1, 1.2] # fire rate
	current_level = 1
	max_level = 2
	
func fire() -> void:
	if not current_target:
		return
	var bullet = b.instantiate()
	bullet.target = current_target
	bullet.bullet_damage = bullet_damage
	arrow_container.add_child(bullet)
	bullet.global_position = global_position

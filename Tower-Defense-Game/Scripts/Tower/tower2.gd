# tower2.gd
extends Tower
class_name Tower2
## Tower2 will fire a thunderbolt at the enemy

var thunderbolt = preload("res://Scenes/Towers/thunderbolt.tscn")
var can_fire: bool = true

# set the tower parameters
func _ready():
    super._ready()
    fire_rate = 2.5
    scale_detection_area(10)
    price = 3000
    upgrade_price1 = 2000
    upgrade_price2 = 1000
    option1 = [10, 15] # attack range
    option2 = [2.5, 2.0] # fire rate
    current_level = 1
    max_level = 2

# override the fire function
func fire() -> void:
    if not can_fire or not current_target or not is_instance_valid(current_target):
        return
    can_fire = false
    var bolt = thunderbolt.instantiate()
    get_parent().add_child(bolt)
    bolt.global_position = current_target.global_position
    await get_tree().create_timer(fire_rate).timeout
    can_fire = true
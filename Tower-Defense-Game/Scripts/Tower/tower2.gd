extends Tower
class_name Tower2


#var MagicBullet = preload("res://Scenes/magic_projectile.tscn")

var slow_effect: float = 0.5
var slow_duration: float = 2.0



func _ready():
    super._ready()
    bullet_damage = 100
    fire_rate = 0.5
    scale_detection_area(10)

    price = 3000
    upgrade_price1 = 2000
    upgrade_price2 = 1000
    option1 = [10, 15] # attack range
    option2 = [0.5, 0.1] # fire rate


"""func fire() -> void:
    if not current_target:
        return
    var magic = MagicBullet.instantiate()
    magic.target = current_target
    magic.bullet_damage = bullet_damage
    magic.slow_effect = slow_effect
    magic.slow_duration = slow_duration
    arrow_container.add_child(magic)
    magic.global_position = global_position"""

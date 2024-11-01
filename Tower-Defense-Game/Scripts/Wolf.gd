extends EnemyBase
class_name Wolf

func _ready():
	super._ready()
	speed = base_speed * 2
	health = base_health * 3
	reward = base_reward * 2
	damage = damage_to_player * 2
	original_speed = speed
	$Animation.flip_h = true

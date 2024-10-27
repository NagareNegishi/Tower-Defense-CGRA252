extends EnemyBase
class_name Wolf

func _ready():
	super._ready()
	speed = base_speed * 2
	health = base_health
	reward = base_reward * 3
	$Animation.flip_h = true

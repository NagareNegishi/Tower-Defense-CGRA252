extends EnemyBase
class_name Wolf

func _ready():
	super._ready()
	speed = base_speed * 2
	health = base_health
	$Animation.flip_h = true

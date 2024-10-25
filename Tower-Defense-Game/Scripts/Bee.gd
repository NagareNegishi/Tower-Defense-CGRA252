extends EnemyBase
class_name Bee

func _ready():
	super._ready()
	speed = base_speed * 3
	health = base_health * 0.5
	$Animation.flip_h = true
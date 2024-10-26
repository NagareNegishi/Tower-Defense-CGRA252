extends EnemyBase
class_name Goblin

func _ready():
	super._ready()
	speed = base_speed
	health = base_health * 3
	reward = base_reward * 5
	$Animation.flip_h = true

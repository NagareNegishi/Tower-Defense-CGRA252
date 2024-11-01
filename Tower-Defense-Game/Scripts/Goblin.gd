extends EnemyBase
class_name Goblin

func _ready():
	super._ready()
	speed = base_speed
	health = base_health * 10
	reward = base_reward * 2
	damage = damage_to_player * 3
	original_speed = speed
	$Animation.flip_h = true

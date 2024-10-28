extends EnemyBase
class_name Goblin

func _ready():
	super._ready()
	speed = base_speed
	health = base_health * 5
	reward = base_reward * 10
	damage = damage_to_player * 5
	original_speed = speed
	$Animation.flip_h = true

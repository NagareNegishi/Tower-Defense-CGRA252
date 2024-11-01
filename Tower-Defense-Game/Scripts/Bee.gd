extends EnemyBase
class_name Bee

func _ready():
	super._ready()
	speed = base_speed * 3
	health = base_health
	reward = base_reward
	damage = damage_to_player
	original_speed = speed
	$Animation.flip_h = true

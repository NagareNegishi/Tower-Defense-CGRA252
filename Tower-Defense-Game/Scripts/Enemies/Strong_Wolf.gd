extends EnemyBase
class_name Strong_Wolf

var animation: AnimatedSprite2D

# Strong and large goblin
func _ready():
	if has_node("Animation"):
		animation = $Animation
		animation.scale = Vector2(2, 2)
		var offset = -10 * animation.scale.y
		animation.position = Vector2(0, offset)
	super._ready()
	speed = base_speed * 2
	health = base_health * 8
	reward = base_reward * 8
	damage = damage_to_player * 2
	original_speed = speed
extends EnemyBase
class_name Boss_Goblin

var animation: AnimatedSprite2D

# Strong and large goblin
func _ready():
	if has_node("Animation"):
		animation = $Animation
		animation.scale = Vector2(3, 3)
		var offset = -10 * animation.scale.y
		animation.position = Vector2(0, offset)
	super._ready()
	health = base_health * 20
	reward = base_reward * 5
	damage = damage_to_player * 5
	original_speed = speed


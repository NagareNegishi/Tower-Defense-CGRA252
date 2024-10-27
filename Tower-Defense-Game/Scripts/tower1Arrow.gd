extends CharacterBody2D
class_name tower1Arrow

var target: EnemyBase
@export var speed: float = 1000.0
@export var bullet_damage: float = 100.0

# Set the target to follow
func _physics_process(delta):
	#Null check for target
	if not is_instance_valid(target):
		queue_free()
		return
	var direction := (target.global_position - global_position).normalized() #calculate direction to fly in
	global_position += direction * speed * delta
	look_at(target.global_position)

# Check if the bullet hits the enemy
func _on_area_2d_body_entered(body):
	if body is EnemyBase:
		body.take_damage(bullet_damage)
		queue_free()


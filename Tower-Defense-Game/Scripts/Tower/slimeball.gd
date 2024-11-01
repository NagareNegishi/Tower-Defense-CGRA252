extends CharacterBody2D
class_name slimeball

var target: EnemyBase
@export var speed: float = 600.0
@export var bullet_damage: float = 400.0
var targets: Array = []


# Set the target to follow
func _physics_process(delta):
	#Null check for target removes arrow from game
	if not is_instance_valid(target):
		queue_free()
		return
	#calculate direction to fly in
	var direction := (target.global_position - global_position).normalized() 
	global_position += direction * speed * delta
	look_at(target.global_position)

func _on_area_2d_body_entered(body):
	if body is EnemyBase:
		for bodies in targets:
			bodies.take_damage(bullet_damage)
		$AnimatedSprite2D.scale = Vector2(2, 2)
		$AnimatedSprite2D.play("onhit")
		await $AnimatedSprite2D.animation_finished
		queue_free()




func _on_area_2d_2_body_entered(body):
	if body is EnemyBase:
		targets.append(body)



func _on_area_2d_2_body_exited(body):
	if body is EnemyBase:
		targets.erase(body)



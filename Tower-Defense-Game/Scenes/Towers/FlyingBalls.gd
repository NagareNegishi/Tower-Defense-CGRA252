extends Node2D

# Variables
var speed = -1  # rotation speed (in radians per second)
var radius = 100  # desired orbit radius
var damage: int = 200
var fire_rate: float = 4.0  # 4 seconds interval
var count = 0  # Counter to track full rotations

func _ready():
	# Set the starting position based on radius
	$Node2D.position = Vector2(radius, 0)

func _process(delta):
	# Rotate the node
	rotation += speed * delta
	var animated_sprite = $Node2D/AnimatedSprite2D
	if animated_sprite:
		animated_sprite.play()
	
	# Check if a full rotation has been completed
	if abs(rotation) >= TAU:
		# Reset rotation to 0 and increment the counter
		rotation = 0
		count += 1
		
		# Check if two full rotations have been completed
		if count == 2:
			speed = 0
			$Node2D/AnimatedSprite2D.play("Death")
			
			# Await the animation finished signal
			await $Node2D/AnimatedSprite2D.animation_finished
			queue_free()  # Delete itself after the Death animation completes

@warning_ignore("unused_parameter")
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is EnemyBase:
		body.take_damage(damage)

extends CharacterBody2D
class_name tower1Arrow

#changed this to acire target
var target : CharacterBody2D
var Speed = 1000
var pathName = ""
var bulletDamage 


func _physics_process(delta):
	#Null check for target
	if target != null and is_instance_valid(target):
		
		#calculate direction to fly in
		var direction = (target.global_position - global_position).normalized()
		
		#Moves arrow to target move and slide for some reason attaches the arrow to enemies path
		global_position += direction * Speed * delta
		
		look_at(target.global_position)
		
	#Queue free for consecutive arrows after enemy defeat
	if target == null:
		queue_free()

func _on_area_2d_body_entered(body):
	if "Slime" in body.name or "Bee" in body.name or "Wolf" in body.name or "Goblin" in body.name:
		#target = body.global_position
		body.health -= bulletDamage
		queue_free()


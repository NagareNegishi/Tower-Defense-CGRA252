extends CharacterBody2D
class_name tower1Arrow

#changed this to acire target
var target: Vector2 = Vector2.ZERO

var Speed = 1000
var pathName = ""
var bulletDamage = 100

func _physics_process(delta):
	var pathSpawnerNode = get_node("Spawner")
	
	#for i in range(pathSpawnerNode.get_child_count()):
		#if pathSpawnerNode.get_child(i).name == pathName:
			#target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position

	velocity = global_position.direction_to(target) * Speed

	look_at(target)

	move_and_slide()

func _on_area_2d_body_entered(body):
	if "Slime" in body.name or "Bee" in body.name or "Wolf" in body.name or "Goblin" in body.name:
		target = body.global_position
		body.health -= bulletDamage
		queue_free()
#BROCK
#arrow only fires once when emey enters area and misses so needed a timer to queue free
func _on_timer_timeout():
	queue_free()

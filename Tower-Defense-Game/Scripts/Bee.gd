extends CharacterBody2D

class_name Bee

#speed and health
@export var speed = 50
var health = 1000

func _ready():
	add_to_group("enemy")
	#play walking anim on spawn
	$Animation.play("Walk")
	$Animation.flip_h = true
	
func _process(delta):
	# print(health) # commenting out for now
	#get and set progress along path
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	
	#when enemy reaches end despwan can add damage to player off this call
	if get_parent().get_progress_ratio() == 1:
		Global.enemyCount -= 1
		Global.playerHealth -= 1
		queue_free()
	
	
	
	if health <= 0:
		#stop movement
		set_process(false)
		Global.playerGold += 1
		Global.enemyCount -= 1
		#play death animation and wait for it to finish
		$Animation.play("Death")
		await  $Animation.animation_finished
		#despawn enemy
		print("dead")
		queue_free()

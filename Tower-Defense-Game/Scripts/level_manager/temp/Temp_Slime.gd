extends CharacterBody2D

## delete this line
signal reached_goal
signal enemy_died
###################

#speed and health
@export var speed = 50
var health = 100

func _ready():
	#play walking anim on spawn
	$Animation.play("Walk")

func _process(delta):
	#get and set progress along path
	var path = get_parent().get_parent()
	path.set_progress(path.get_progress() + speed * delta)
	
	#when enemy reaches end despwan can add damage to player off this call
	if get_parent().get_progress_ratio() >= 1:
		## delete this block############
		reached_goal.emit()
		#print("reached goal")
		########################
		queue_free()
	
	if health <= 0:
		#stop movement
		set_process(false)
		#play death animation and wait for it to finish
		$Animation.play("Death")
		await  $Animation.animation_finished
		#despawn enemy
		enemy_died.emit()
		queue_free()
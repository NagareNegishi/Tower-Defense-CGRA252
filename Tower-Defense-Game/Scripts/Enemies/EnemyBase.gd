extends CharacterBody2D
class_name EnemyBase

# base parameters
@export var base_speed: float = 100
@export var base_health: float = 100
@export var base_reward: int = 10
@export var damage_to_player: int = 1

# actual parameters
var speed: float
var health: float
var reward: int
var damage: int

signal reached_goal(damage: int)
signal enemy_died(reward: int)

func _ready():
	speed = base_speed
	health = base_health
	reward = base_reward
	damage = damage_to_player
	add_to_group("enemy")
	_play_walk_animation()


func _process(delta):
	_move(delta)
	_check_goal()
	_check_health()

func _play_walk_animation():
	if has_node("Animation"):
		$Animation.play("Walk")

# move the enemy along the path and flip the sprite if needed
func _move(delta):
	if get_parent():
		var old_pos = global_position
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
		get_parent().rotates = false
		var new_pos = global_position
		if new_pos.x < old_pos.x:
			if has_node("Animation"):
				$Animation.flip_h = false
		elif new_pos.x > old_pos.x:
			if has_node("Animation"):
				$Animation.flip_h = true


func _check_goal():
	if get_parent() and get_parent().get_progress_ratio() >= 1:
		_on_reach_goal()

func _check_health():
	if health <= 0:
		_on_death()

func _on_reach_goal():
	Global.playerHealth -= damage
	Global.enemyCount -= 1
	reached_goal.emit(damage)
	print("Enemy reached goal")###########################################
	queue_free()

func _on_death():
	set_process(false)
	Global.playerGold += reward
	Global.enemyCount -= 1
	if has_node("Animation"):
		$Animation.play("Death")
		await $Animation.animation_finished
	enemy_died.emit(reward)
	print("Enemy died")################################################
	queue_free()

func take_damage(amount: float):
	health -= amount
	print("Enemy took damage: ", amount)#########################################
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

# slow down the enemy
@onready var slow_timer: Timer = Timer.new()
var original_speed: float
var slow_rate: float = 0.0

signal reached_goal(damage: int)
signal enemy_died(reward: int)

# initialize the enemy
func _ready():
	speed = base_speed
	health = base_health
	reward = base_reward
	damage = damage_to_player
	add_to_group("enemy")
	set_timer()
	_play_walk_animation()

# set the timer for the slow effect
func set_timer():
	add_child(slow_timer)
	slow_timer.one_shot = true
	slow_timer.timeout.connect(_reset_speed)
	original_speed = speed

# process the enemy
func _process(delta):
	_move(delta)
	_check_goal()
	_check_health()

# play the walk animation
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

# check if the enemy reached the goal
func _check_goal():
	if get_parent() and get_parent().get_progress_ratio() >= 1:
		_on_reach_goal()

# check if the enemy is dead
func _check_health():
	if health <= 0:
		_on_death()

# enemy reached the goal and damaged the player
func _on_reach_goal():
	Global.playerHealth -= damage
	Global.enemyCount -= 1
	reached_goal.emit(damage)
	queue_free()

# enemy died and reward the player
func _on_death():
	set_process(false)
	enemy_died.emit(reward)
	Global.enemyCount -= 1
	Global.playerGold += reward
	if has_node("Animation"):
		$Animation.play("Death")
		await $Animation.animation_finished
	queue_free()

# take damage from the player
func take_damage(amount: float):
	health -= amount

# slow down the enemy for a duration, use ratio for the slow rate
func slowdown(rate: float, duration: float):
	if rate > slow_rate: # possibley slow down more
		slow_rate = rate
		speed = original_speed * (1.0 - slow_rate)
		slow_timer.wait_time = duration
		slow_timer.start()

# reset the speed after the slow effect
func _reset_speed():
	speed = original_speed
	slow_rate = 0.0

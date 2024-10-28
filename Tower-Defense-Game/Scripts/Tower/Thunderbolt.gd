extends Area2D
class_name Thunderbolt
## Thunderbolt will deal damage to enemies in range and slow them down
var damage: float = 50.0
var slow_effect: float = 0.5 # 50% slow
var slow_duration: float = 0.8 # 0.8 seconds
const MAX_STRIKES: int = 4

@onready var lightning1 = $Lightning1
@onready var lightning2 = $Lightning2
@onready var lightning3 = $Lightning3

# set the collision layers and start the strikes
func _ready():
    # it is set in the editor, but just in case
    collision_layer = 4 # layer for attacking enemies
    collision_mask = 2 # layer for enemies only
    monitoring = true
    monitorable = false
    lightning1.play("one")
    lightning2.play("two")
    lightning3.play("three")
    for i in range(MAX_STRIKES):
        deal_damage()
        if i < 3: # avoid rapid strikes
            await get_tree().create_timer(0.5).timeout
    await get_tree().create_timer(0.4).timeout # wait for the last strike
    queue_free()

# deal damage to enemies in the area
func deal_damage() -> void:
    # get all the bodies in the area
    var bodies = get_overlapping_bodies()
    if bodies.is_empty():
        return
    for body in bodies:
        if body is EnemyBase:
            body.take_damage(damage)
            body.slowdown(slow_effect, slow_duration)
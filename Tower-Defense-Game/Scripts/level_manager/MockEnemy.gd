extends Node2D


class_name MockEnemy

signal reached_end
signal died

var speed = 50
var health = 100
var path_length = 1000
var current_distance = 0

func _process(delta):
    current_distance += speed * delta
    if current_distance >= path_length:
        emit_signal("reached_end")
        queue_free()

func take_damage(amount):
    health -= amount
    if health <= 0:
        emit_signal("died")
        queue_free()

func _ready():
    print("Mock enemy spawned")
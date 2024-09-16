extends Node
class_name GameStats

var score: int = 0
var life: int = 100
var resources: int = 1000

func update_score(amount: int):
	score += amount

func update_life(amount: int):
	life -= amount

func update_resources(amount: int):
	resources += amount

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

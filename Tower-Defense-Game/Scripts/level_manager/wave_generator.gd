extends Node
class_name WaveGenerator

func create_wave(difficulty: int) -> Wave:
	var wave = Wave.new()
	return wave

func create_waves(num_waves: int, start_difficulty: int) -> Array:
	var waves = []
	for i in range(num_waves):
		waves.append(create_wave(start_difficulty + i))
	return waves

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

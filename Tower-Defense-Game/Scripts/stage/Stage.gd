extends Node2D
class_name Stage

var enemy_path: Path2D
var platforms: Array[Node] = []
var towers: Array[Node] = []
const MIN_TOWER_DISTANCE: float = 70.0  # distance between towers
var tower_scene = preload("res://Scenes/tower1.tscn")

var input_manager: InputManager

func _ready():
	enemy_path = $Path2D
	platforms = $Platforms.get_children()

func handle_tower_placement_request(tower_position: Vector2):
	if is_valid_tower_position(tower_position):
		add_tower(tower_position)
		input_manager.end_tower_placement()
	else:
		print("Invalid tower position")


func is_valid_tower_position(tower_position: Vector2) -> bool:
	var on_platform = false
	for platform in platforms:
		if platform is Platform and platform.contains_point(tower_position):
			on_platform = true
			break

	if not on_platform:
		return false
	
	# check if the tower is too close to another tower
	for tower in towers:
		if tower_position.distance_to(tower.position) < MIN_TOWER_DISTANCE:
			return false
	
	return true

func add_tower(tower_position: Vector2):
	var new_tower = tower_scene.instantiate()
	towers.append(new_tower)
	add_child(new_tower)
	new_tower.position = tower_position
	new_tower.connect("tower_placed", Callable(self, "_on_tower_placed"))
	print("Tower placed at ", new_tower.position)

func _on_tower_placed(tower: Tower):
	print("Tower placed at ", tower.position)

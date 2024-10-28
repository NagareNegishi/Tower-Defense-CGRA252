extends Node2D
class_name Stage

var enemy_path: Path2D
var platforms: Array[Node] = []
var towers: Array[Tower] = []
const MIN_TOWER_DISTANCE: float = 70.0  # distance between towers

@export var game_stats: GameStats
@export var input_manager: InputManager
@export var tower_manager: TowerManager
var selected_tower: Tower = null

# set up connections
func _ready():
	enemy_path = $Path2D
	platforms = $Platforms.get_children()

# handle tower placement request from input manager
# location is checked in this class, cost and scene are checked in TowerManager
func handle_tower_placement_request(tower_position: Vector2):
	var tower_type = input_manager.current_tower_type
	if is_valid_tower_position(tower_position):
		if tower_manager.can_build_tower(tower_type):
			var tower_scene = tower_manager.get_tower_scene(tower_type)
			add_tower(tower_position, tower_scene)
			input_manager.handle_placement_result(true)
		else :
			input_manager.handle_placement_result(false)
			print("Not enough gold to build tower")
	else:
		input_manager.handle_placement_result(false)
		print("Invalid tower position")

# check if the tower position is valid
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

# add a tower to the stage
func add_tower(tower_position: Vector2, tower_scene: PackedScene):
	var new_tower = tower_scene.instantiate()
	towers.append(new_tower)
	add_child(new_tower)
	new_tower.position = tower_position
	game_stats.gold -= new_tower.price
	game_stats.towers_built += 1
	Global.playerGold = game_stats.gold
	print("Tower placed at ", new_tower.position)

# handle tower selection
func _on_tower_selected(tower: Tower):
	if selected_tower and is_instance_valid(selected_tower):
		selected_tower.selection_rect.visible = false
	selected_tower = null
	
	if tower and is_instance_valid(tower):
		selected_tower = tower
		selected_tower.selection_rect.visible = true


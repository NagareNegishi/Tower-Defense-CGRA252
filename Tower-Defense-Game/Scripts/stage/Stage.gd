extends Node2D
class_name Stage

var enemy_path: Path2D
var platforms: Array[Node] = []
var towers: Array[Node] = []
const MIN_TOWER_DISTANCE: float = 100.0  # distance between towers

func _ready():
    enemy_path = $Path2D
    platforms = $Platforms.get_children()

func is_valid_tower_position(position: Vector2) -> bool:
    var on_platform = false
    for platform in platforms:
        if platform is Node2D and position.distance_to(platform.position) < 36: # adjust this value to fit platform size
            on_platform = true
            break
    
    if not on_platform:
        return false
    
    # check if the tower is too close to another tower
    for tower in towers:
        if position.distance_to(tower.position) < MIN_TOWER_DISTANCE:
            return false
    
    return true

func add_tower(tower: Tower, position: Vector2):
    if is_valid_tower_position(position):
        towers.append(tower)
        add_child(tower)
        tower.position = position
        tower.connect("tower_placed", Callable(self, "_on_tower_placed"))
    else:
        print("Invalid tower position")

func _on_tower_placed(tower: Tower):
    print("Tower placed at ", tower.position)
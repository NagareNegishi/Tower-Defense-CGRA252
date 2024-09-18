extends Node
class_name LevelManager

var waves = [] # for prototype
var current_wave: Wave = null
var next_wave: Wave = null
var total_waves = 5 # 5 to 10 waves per level
var current_level = 1
var total_levels = 5
var current_difficulty = 1
var current_state = GameState.BETWEEN_WAVES
enum GameState {
    WAVE_IN_PROGRESS,
    BETWEEN_WAVES,
    GAME_OVER,
    VICTORY
}

@export var game_stats: GameStats


@export var wave_scene: PackedScene
@export var strength_estimator: StrengthEstimator  #I need to wait others code

signal waves_complete # finished sending all waves
signal level_complete # all waves are defeated
signal player_defeat # player lost
signal game_complete # player won

# Called when the node enters the scene tree for the first time.
func _ready():
	game_stats = GameStats.new()
	add_child(game_stats)
	game_stats.connect("game_over", Callable(self, "_on_game_over"))
	
	strength_estimator = StrengthEstimator.new()
	add_child(strength_estimator)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_level():
	send_waves()

func send_waves():
	current_state = GameState.WAVE_IN_PROGRESS
	while not waves.empty():
		current_wave = waves.pop_front()
		add_child(current_wave)
		current_wave.start()
		total_waves - 1
	waves_complete.emit()


func _on_level_complete():
	current_state = GameState.BETWEEN_WAVES
	current_level += 1
	if current_level > total_levels:
		current_state = GameState.VICTORY
		game_complete.emit()
	

func _on_game_over():
	current_state = GameState.GAME_OVER
	player_defeat.emit()
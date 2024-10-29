extends Node
# SceneManager is responsible for changing scenes in the game
# it is AutoLoaded

const GAMEOVER_SCENE := "res://Scenes/Menu/GameOver_Menu.tscn"
const VICTORY_SCENE := "res://Scenes/Menu/Victory_Menu.tscn"
const MAIN_MENU_SCENE := "res://Scenes/Prototype/Main_Menu.tscn"

# Change the scene to the given path
func change_scene(scene_path: String) -> void:
	if Engine.get_main_loop(): # Check if the engine is running to avoid errors
		var error = get_tree().change_scene_to_file(scene_path)
		if error != OK:
			push_error("Failed to load scene: " + scene_path)

# Change the scene to the game over menu
func game_over() -> void:
	change_scene(GAMEOVER_SCENE)

# Change the scene to the victory menu
func victory() -> void:
	change_scene(VICTORY_SCENE)

# Change the scene to the main menu
func main_menu() -> void:
	change_scene(MAIN_MENU_SCENE)
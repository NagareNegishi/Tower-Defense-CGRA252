extends Node

const GAMEOVER_SCENE := "res://Scenes/Menu/GameOver_Menu.tscn"
const VICTORY_SCENE := "res://Scenes/Menu/Victory_Menu.tscn"
const MAIN_MENU_SCENE := "res://Scenes/Prototype/Main_Menu.tscn"

func change_scene(scene_path: String) -> void:
	if Engine.get_main_loop():
		var error = get_tree().change_scene_to_file(scene_path)
		if error != OK:
			push_error("Failed to load scene: " + scene_path)

func game_over() -> void:
	change_scene(GAMEOVER_SCENE)

func victory() -> void:
	change_scene(VICTORY_SCENE)

func main_menu() -> void:
	change_scene(MAIN_MENU_SCENE)
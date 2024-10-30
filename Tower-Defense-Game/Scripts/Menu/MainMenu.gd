extends Control
class_name MainMenu

const GAME_SCENE := "res://Scenes/Prototype/game.tscn"
const SETTINGS_SCENE := "res://Scenes/SettingsMenu.tscn"

# play the game
func _on_start_game_click_end() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(GAME_SCENE)

# open the settings menu
func _on_setting_click_end() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(SETTINGS_SCENE)

# exit the game
func _on_exit_game_click_end() -> void:
	get_tree().quit()

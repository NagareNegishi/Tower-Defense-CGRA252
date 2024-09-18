extends Control

var level = ""
var setting = ""



func _on_start_game_click_end():
	var _level = get_tree().change_scene_to_file(level)


func _on_setting_click_end():
	var _level = get_tree().change_scene_to_file(setting)


func _on_exit_game_click_end():
	get_tree().quit()

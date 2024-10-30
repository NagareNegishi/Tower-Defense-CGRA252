extends Control
class_name EndMenu

const GAME_SCENE := "res://Scenes/Prototype/game.tscn"

# play the game
func _on_start_game_click_end() -> void:
    await get_tree().create_timer(0.1).timeout
    var tree = get_tree()
    if tree:
        tree.change_scene_to_file(GAME_SCENE)

# exit the game
func _on_exit_game_click_end() -> void:
    get_tree().quit()

extends Path2D

signal enemy_reached_end

func _ready():
	print("WavePath _ready called")
	var path_follow = get_node_or_null("PathFollow2D")
	if path_follow:
		for child in path_follow.get_children():
			print("Connecting to child: ", child.name)
			if not child.is_connected("tree_exiting", _on_enemy_tree_exiting):
				child.connect("tree_exiting", _on_enemy_tree_exiting)
	else:
		print("PathFollow2D not found")

func _on_enemy_tree_exiting():
	print("Enemy is being removed")
	emit_signal("enemy_reached_end")

func connect_to_spawner(spawner):
	print("Connecting to spawner")
	if not is_connected("enemy_reached_end", spawner._on_enemy_reached_goal):
		connect("enemy_reached_end", spawner._on_enemy_reached_goal)

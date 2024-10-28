extends Button

var selected_tower = null  # Reference to the selected tower

func _ready():
	$UpgradeButton.connect("pressed", Callable(self, "_on_upgrade_button_pressed"))

# When the upgrade button is pressed, upgrade the selected tower
func _on_upgrade_button_pressed():
	if selected_tower:
		selected_tower.level_up()
	else:
		print("No tower selected to upgrade.")

# Function to set the currently selected tower
func select_tower(tower):
	selected_tower = tower

# Function to deselect the tower
func deselect_tower():
	selected_tower = null

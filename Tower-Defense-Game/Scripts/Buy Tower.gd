extends Button

func _ready():
	# Create base style
	var style = create_base_style()
	# Create state-specific styles
	var hover_style = create_hover_style(style)
	var disabled_style = create_disabled_style(style)
	var pressed_style = create_pressed_style(style)
	var focus_style = create_focus_style(style)
	# Apply all styles
	apply_styles(style, hover_style, disabled_style, pressed_style, focus_style)
	# Configure focus behavior
	focus_mode = Control.FOCUS_NONE

# Base style configuration
func create_base_style() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	# round corners
	style.set_corner_radius_all(30)
	style.anti_aliasing_size = 0.8
	style.bg_color = Color(1.0, 0.65, 0.0, 0.3)  # Orange with 0.8 alpha
	# Border configuration
	style.set_border_width(SIDE_LEFT, 1)
	style.set_border_width(SIDE_RIGHT, 1)
	style.set_border_width(SIDE_TOP, 1)
	style.set_border_width(SIDE_BOTTOM, 1)
	style.border_color = Color(1.0, 0.5, 0.0, 0.1)  # Darker orange border
	return style

# Hover state style
func create_hover_style(base_style: StyleBoxFlat) -> StyleBoxFlat:
	var hover_style = base_style.duplicate()
	hover_style.bg_color = Color(1.0, 0.7, 0.0, 0.9)  # Slightly lighter orange
	hover_style.border_color = Color(1.0, 0.6, 0.0, 0.6)
	return hover_style

# Disabled state style
func create_disabled_style(base_style: StyleBoxFlat) -> StyleBoxFlat:
	var disabled_style = base_style.duplicate()
	disabled_style.bg_color = Color(0.3, 0.3, 0.3, 0.9)  # Gray out when disabled
	disabled_style.border_color = Color(0.2, 0.2, 0.2, 0.5)
	return disabled_style

# Pressed state style
func create_pressed_style(base_style: StyleBoxFlat) -> StyleBoxFlat:
	var pressed_style = base_style.duplicate()
	pressed_style.bg_color = Color(0.9, 0.5, 0.0, 1.0)  # Darker orange when pressed
	return pressed_style

# Focus state style
func create_focus_style(base_style: StyleBoxFlat) -> StyleBoxFlat:
	var focus_style = base_style.duplicate()
	focus_style.bg_color = Color(1.0, 0.7, 0.2, 0.85)
	focus_style.border_color = Color(1.0, 0.6, 0.0, 0.7)
	return focus_style

# Apply all styles to the button
func apply_styles(normal: StyleBoxFlat, hover: StyleBoxFlat,
	dis: StyleBoxFlat, pre: StyleBoxFlat, focus: StyleBoxFlat) -> void:
	# Apply styleboxes
	add_theme_stylebox_override("normal", normal)
	add_theme_stylebox_override("hover", hover)
	add_theme_stylebox_override("disabled", dis)
	add_theme_stylebox_override("pressed", pre)
	add_theme_stylebox_override("focus", focus)
	# Apply font colors for different states
	add_theme_color_override("font_color", Color.WHITE)
	add_theme_color_override("font_hover_color", Color.WHITE)
	add_theme_color_override("font_disabled_color", Color(0.5, 0.5, 0.5, 1.0))
	add_theme_color_override("font_pressed_color", Color.WHITE)
	add_theme_color_override("font_focus_color", Color.WHITE)

func _process(_delta):
	if Global.playerGold >= 100:
		disabled = false

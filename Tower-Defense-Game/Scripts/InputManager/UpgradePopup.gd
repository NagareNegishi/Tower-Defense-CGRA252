extends Control
class_name UpgradePopup

signal upgrade_confirmed(tower: Tower, path: String)
signal upgrade_cancelled

@onready var damage_button: Button = $Choice1
@onready var speed_button: Button = $Choice2
@onready var cancel_button: Button = $Cancel

var current_tower: Tower

const OFFSET_Y = -100
const OFFSET_X = 50

func _ready() -> void:
    print("UpgradePopup _ready called")

    damage_button.mouse_filter = Control.MOUSE_FILTER_STOP
    speed_button.mouse_filter = Control.MOUSE_FILTER_STOP
    cancel_button.mouse_filter = Control.MOUSE_FILTER_STOP
    

    damage_button.pressed.connect(_on_damage_pressed)
    speed_button.pressed.connect(_on_speed_pressed)
    cancel_button.pressed.connect(_on_cancel_pressed)
    
    print("Signals connected")

func setup(tower: Tower) -> void:
    print("Setting up upgrade popup for tower level: ", tower.current_level)
    current_tower = tower
    update_button_states()
    position_popup_near_tower()

func position_popup_near_tower() -> void:
    if current_tower:
        global_position = Vector2(
            current_tower.global_position.x + OFFSET_X,
            current_tower.global_position.y + OFFSET_Y
        )
        ensure_popup_in_viewport()

func ensure_popup_in_viewport() -> void:
    var viewport_size = get_viewport_rect().size
    if global_position.x + size.x > viewport_size.x:
        global_position.x = viewport_size.x - size.x
    if global_position.x < 0:
        global_position.x = 0
    if global_position.y + size.y > viewport_size.y:
        global_position.y = viewport_size.y - size.y
    if global_position.y < 0:
        global_position.y = 0

func update_button_states() -> void:
    if not current_tower:
        return
    
    var can_upgrade = current_tower.current_level < current_tower.MAX_LEVEL
    var can_afford_damage = Global.playerGold >= current_tower.upgrade_price
    damage_button.disabled = not (can_afford_damage and can_upgrade)
    
    var speed_cost = current_tower.upgrade_price * 1.5
    var can_afford_speed = Global.playerGold >= speed_cost
    speed_button.disabled = not (can_afford_speed and can_upgrade)

func _on_damage_pressed() -> void:
    print("Damage upgrade confirmed")
    upgrade_confirmed.emit(current_tower, "damage")
    hide()

func _on_speed_pressed() -> void:
    print("Speed upgrade confirmed")
    upgrade_confirmed.emit(current_tower, "speed")
    hide()

func _on_cancel_pressed() -> void:
    upgrade_cancelled.emit()
    hide()
extends GridNode
class_name GridSlot

@export var icon: TextureRect

var _grid_position: Vector2i
var _slot_state: SlotStates = SlotStates.SLOT_DEFAULT

func _ready() -> void:
	_set_state(SlotStates.SLOT_DEFAULT)
	icon.mouse_entered.connect(self._on_mouse_entered)
	icon.mouse_exited.connect(self._on_mouse_exited)

func set_grid_position(_position: Vector2i) -> void:
	_grid_position = _position

func _on_mouse_entered() -> void:
	_set_state(SlotStates.SLOT_HOVER)
	# print_debug("mouse entered slot")

func _on_mouse_exited() -> void:
	_set_state(SlotStates.SLOT_DEFAULT)
	# print_debug("mouse exited slot")

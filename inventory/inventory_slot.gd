extends Control
class_name InventorySlot

enum SlotStates{
	SLOT_DEFAULT,
	SLOT_HOVER,
	SLOT_TAKEN,
	SLOT_OPEN,
}

var _grid_position: Vector2i
var _slot_state: SlotStates = SlotStates.SLOT_DEFAULT

func set_grid_position(_position: Vector2i) -> void:
	_grid_position = _position


func _on_mouse_entered() -> void:
	pass # Replace with function body.


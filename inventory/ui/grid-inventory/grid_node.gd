extends Control
class_name GridNode

enum SlotStates{
	SLOT_DEFAULT,
	SLOT_HOVER,
	SLOT_TAKEN,
	SLOT_OPEN,
}

enum ItemStates{
	ITEM_DEFAULT,
	ITEM_HOVER,
	ITEM_HELD,
}

var _state

func is_hovered() -> bool:
	if _state == ItemStates.ITEM_HOVER || _state == SlotStates.SLOT_HOVER:
		return true

	return false

func _set_state(_s) -> void:
	_state = _s
	_on_state_change()

func _on_state_change() -> void:
	match _state:
		SlotStates.SLOT_DEFAULT:
			self.modulate = Color(1, 1, 1, 1)
		SlotStates.SLOT_HOVER:
			self.modulate = Color(0.5, 0.5, 0.5, 1)
		SlotStates.SLOT_TAKEN:
			self.modulate = Color(0.8, 0.8, 0.8, 1)
		SlotStates.SLOT_OPEN:
			self.modulate = Color(0.2, 0.2, 0.2, 1)
		ItemStates.ITEM_DEFAULT:
			mouse_filter = Control.MOUSE_FILTER_PASS
			self.modulate = Color(1, 1, 1, 1)
		ItemStates.ITEM_HOVER:
			self.modulate = Color(0.5, 0.5, 0.5, 1)
		ItemStates.ITEM_HELD:
			self.modulate = Color(0.8, 0.8, 0.8, 1)

func _on_mouse_entered() -> void:
	print_debug("mouse entered")

func _on_mouse_exited() -> void:
	print_debug("mouse exited")

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

func _set_state(_s: ItemStates) -> void:
	_state = _s
	_on_state_change()

func _on_state_change() -> void:
	match _state:
		ItemStates.ITEM_DEFAULT:
			self.modulate = Color(1, 1, 1, 1)
		ItemStates.ITEM_HOVER:
			self.modulate = Color(0.5, 0.5, 0.5, 1)
		ItemStates.ITEM_HELD:
			self.modulate = Color(0.8, 0.8, 0.8, 1)

func _on_mouse_entered() -> void:
	_set_state(ItemStates.ITEM_HOVER)
	print_debug("mouse entered")

func _on_mouse_exited() -> void:
	_set_state(ItemStates.ITEM_DEFAULT)
	print_debug("mouse exited")

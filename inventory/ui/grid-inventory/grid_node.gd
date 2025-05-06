extends Control
class_name GridNode

enum NodeStates{
	SLOT_DEFAULT,
	SLOT_HOVER,
	SLOT_TAKEN,
	SLOT_OPEN,
	ITEM_DEFAULT,
	ITEM_LOCKED,
	ITEM_HOVER,
	ITEM_HELD,
}

var _state: NodeStates

func is_hovered() -> bool:
	if _state == NodeStates.ITEM_HOVER || _state == NodeStates.SLOT_HOVER:
		return true

	return false

func _set_state(_s: NodeStates) -> void:
	_state = _s
	_on_state_change()

func _on_state_change() -> void:
	match _state:
		NodeStates.SLOT_DEFAULT:
			mouse_filter = Control.MOUSE_FILTER_PASS
			self.modulate = Color(1, 1, 1, 1)
		NodeStates.SLOT_HOVER:
			self.modulate = Color(0.5, 0.5, 0.5, 1)
		NodeStates.SLOT_TAKEN:
			self.modulate = Color(0.8, 0.2, 0.2, 1)
		NodeStates.SLOT_OPEN:
			self.modulate = Color(0.2, 0.8, 0.2, 1)
		NodeStates.ITEM_DEFAULT:
			mouse_filter = Control.MOUSE_FILTER_PASS
			self.modulate = Color(1, 1, 1, 1)
		NodeStates.ITEM_LOCKED:
			mouse_filter = Control.MOUSE_FILTER_PASS
			self.modulate = Color(0.2, 0.1, 0.1, 1)
		NodeStates.ITEM_HOVER:
			self.modulate = Color(0.8, 0.8, 0.8, 1)
		NodeStates.ITEM_HELD:
			self.modulate = Color(1, 1, 1, 0.6)

func _on_mouse_entered() -> void:
	print_debug("mouse entered")

func _on_mouse_exited() -> void:
	print_debug("mouse exited")

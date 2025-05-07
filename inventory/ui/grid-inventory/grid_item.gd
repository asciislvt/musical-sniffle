extends GridNode
class_name GridItem

@export var icon: TextureRect

var _id: int
var _anchor: Vector2i
var _pos_taken: Array[Vector2i]
var _offsets: Array[Vector2i]

func _ready() -> void:
	_set_state(NodeStates.ITEM_DEFAULT)
	icon.mouse_entered.connect(self._on_mouse_entered)
	icon.mouse_exited.connect(self._on_mouse_exited)

func _process(delta: float) -> void:
	if _state == NodeStates.ITEM_HELD:
		var _mouse_pos = get_global_mouse_position()
		global_position = global_position.lerp(_mouse_pos - (icon.size / 2), 20 * delta)
	else:
		pass

func get_item_id() -> int:
	return _id

func get_anchor_position() -> Vector2i:
	return _anchor

func load_item(_data: GridItemData) -> void:
	icon.texture = _data.icon
	_id = _data.id
	_anchor = _data.anchor_pos
	_pos_taken = _data.pos_taken
	_offsets = _data.offsets

func hold_item() -> void:
	_set_state(NodeStates.ITEM_HELD)

	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.z_index = 1

func place_item(_anchor_slot: GridSlot) -> void:
	_set_state(NodeStates.ITEM_DEFAULT)
	_set_grid_positions(_anchor_slot._grid_position)

	icon.mouse_filter = Control.MOUSE_FILTER_PASS
	icon.z_index = 0

	var tween = get_tree().create_tween()
	if !tween.is_valid():
		tween.kill()
	
	tween.tween_property(self, "position", _anchor_slot.position, 0.15)

func _set_grid_positions(_pos: Vector2i) -> void:
	_anchor = _pos
	_pos_taken.clear()
	for offset in _offsets:
		_pos_taken.append(_anchor + offset)


func _on_item_held() -> void:
	if _state != NodeStates.ITEM_HELD:
		_set_state(NodeStates.ITEM_LOCKED)
		icon.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_item_placed() -> void:
	_set_state(NodeStates.ITEM_DEFAULT)
	icon.mouse_filter = Control.MOUSE_FILTER_PASS

func _on_mouse_entered() -> void:
	if _state != NodeStates.ITEM_HELD || _state != NodeStates.ITEM_LOCKED:
		_set_state(NodeStates.ITEM_HOVER)

	return

func _on_mouse_exited() -> void:
	if _state != NodeStates.ITEM_HELD:
		_set_state(NodeStates.ITEM_DEFAULT)

	return

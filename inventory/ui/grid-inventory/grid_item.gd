extends GridNode
class_name GridItem

@export var icon: TextureRect

var _anchor: Vector2i
var _pos_taken: Array[Vector2i]
var _offsets: Array[Vector2i]

func _ready() -> void:
	_set_state(ItemStates.ITEM_DEFAULT)
	icon.mouse_entered.connect(self._on_mouse_entered)
	icon.mouse_exited.connect(self._on_mouse_exited)

func _process(delta: float) -> void:
	if _state == ItemStates.ITEM_HELD:
		var _mouse_pos = get_global_mouse_position()
		global_position = global_position.lerp(_mouse_pos - (icon.size / 2), 20 * delta)
	else:
		pass

func load_item(_data: GridItemData) -> void:
	icon.texture = _data.icon
	_anchor = _data.anchor_pos
	_pos_taken = _data.pos_taken
	_offsets = _data.offsets

func hold_item() -> void:
	_set_state(ItemStates.ITEM_HELD)

	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.z_index = 1

func place_item(_anchor_slot: GridSlot) -> void:
	_set_state(ItemStates.ITEM_DEFAULT)

	icon.mouse_filter = Control.MOUSE_FILTER_PASS
	icon.z_index = 0

	var tween = get_tree().create_tween()
	if !tween.is_valid():
		tween.kill()
	
	tween.tween_property(self, "position", _anchor_slot.position, 0.2)

# func _on_item_held() -> void:
# 	if _state != ItemStates.ITEM_HELD:
# 		pass
# 		_set_state(ItemStates.ITEM_HOVER)
#
# func _on_item_placed() -> void:
# 	_set_state(ItemStates.ITEM_DEFAULT)

func _on_mouse_entered() -> void:
	if _state != ItemStates.ITEM_HELD:
		_set_state(ItemStates.ITEM_HOVER)

	return

func _on_mouse_exited() -> void:
	if _state != ItemStates.ITEM_HELD:
		_set_state(ItemStates.ITEM_DEFAULT)

	return

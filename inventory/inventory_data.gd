extends Resource
class_name InventoryData

@export var max_slots: int = 8
@export var grid_width: int = 4
var _grid_positions: Array[Vector2i] = []
var _item_array: Array[GridItemData] = []

func get_grid_width() -> int:
	return grid_width

func get_items() -> Array[GridItemData]:
	return _item_array

func try_add_item(_data: ItemData) -> void:
	var _positions: Array[Vector2i] = _find_free_positions(_data)
	if _positions.is_empty():
		print_debug("no space >:((")
	else:
		_add_item(_positions, _data)

func try_move_item(_id: int, _new_anchor: Vector2i) -> void:
	var _item: GridItemData = _item_array[_id]
	var _positions_taken = _item.get_positions_taken()



# func _move_item(_data: GridItemData) -> void:
# 	pass

func _add_item(_positions: Array[Vector2i], _data: ItemData) -> void:
	var _new_item = GridItemData.new(_positions, _data)
	for _pos in _positions:
		_grid_positions.erase(_pos)
	
	_item_array.append(_new_item)
	_new_item.set_id(_item_array.size() - 1)

func _find_free_positions(_data: ItemData) -> Array[Vector2i]:
	var _item_offset: Array[Vector2i] = _data.shape_offset
	var _positions: Array[Vector2i] = []

	for _anchor in _grid_positions:
		for _offset in _item_offset:
			var _target_pos = _anchor + _offset
			if !_grid_positions.has(_target_pos):
				_positions.clear()
				break
			
			_positions.append(_target_pos)
	
			if _positions.size() == _item_offset.size():
				print_debug("found free positions")
				return _positions

	return _positions

func init_inv() -> void:
	if _grid_positions.is_empty() && max_slots > 0:
		for i in max_slots:
			var _x = i % grid_width
			var _y = i / grid_width
			var _pos = Vector2i(_x, _y)
			_grid_positions.append(_pos)

			# var _debug_string = "New slot created! Position: ({0}, {1})"
			# print_debug(_debug_string.format([_x, _y]))

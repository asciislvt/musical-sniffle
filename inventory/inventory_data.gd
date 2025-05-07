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
	var positions: Array[Vector2i] = _find_free_positions(_data)
	if positions.is_empty():
		print_debug("no space >:((")
	else:
		_add_item(positions, _data)

func try_move_item(_id: int, _new_anchor: Vector2i) -> void:
	var item: GridItemData = _item_array[_id]

	if !_grid_positions.has(_new_anchor):
		return
	else:
		for offset in item.get_offsets():
			var new_pos = _new_anchor + offset
			if _grid_positions.has(new_pos):
				print_debug("position freee")
				continue
			else:
				print_debug("no space >:((")
				return
		_move_item(item, _new_anchor)


func _move_item(_item: GridItemData, _new_anchor: Vector2i) -> void:
	var prev_positions = _item.get_positions_taken()
	for pos in prev_positions:
		_grid_positions.append(pos)
		print_debug("position freed: {0}".format([pos]))
	
	_item.set_position(_new_anchor)
	for pos in _item.get_positions_taken():
		if _grid_positions.has(pos):
			_grid_positions.erase(pos)
	
	
	Global.inv_item_moved.emit(_new_anchor)
	print_debug("item moved!")

func _add_item(_positions: Array[Vector2i], _data: ItemData) -> void:
	var new_item = GridItemData.new(_positions, _data)
	for pos in _positions:
		_grid_positions.erase(pos)
	
	_item_array.append(new_item)
	new_item.set_id(_item_array.size() - 1)

func _find_free_positions(_data: ItemData) -> Array[Vector2i]:
	var item_offset: Array[Vector2i] = _data.shape_offset
	var positions: Array[Vector2i] = []

	for anchor in _grid_positions:
		for offset in item_offset:
			var target_pos = anchor + offset
			if !_grid_positions.has(target_pos):
				positions.clear()
				break
			
			positions.append(target_pos)
	
			if positions.size() == item_offset.size():
				print_debug("found free positions")
				return positions

	return positions

func init_inv() -> void:
	if _grid_positions.is_empty() && max_slots > 0:
		for i in max_slots:
			var _x = i % grid_width
			var _y = i / grid_width
			var pos = Vector2i(_x, _y)
			_grid_positions.append(pos)

			# var _debug_string = "New slot created! Position: ({0}, {1})"
			# print_debug(_debug_string.format([_x, _y]))

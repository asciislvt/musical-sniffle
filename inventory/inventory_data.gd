extends Resource
class_name InventoryData

@export var max_slots: int = 8
@export var grid_width: int = 4
var _grid_positions: Array[Vector2i] = []
var _item_array: Array[GridItemData] = []

func get_grid_width() -> int:
	return grid_width

func try_add_item(_data: ItemData) -> void:
	pass

func init_inv() -> void:
	if _item_array.is_empty():
		for i in max_slots:
			var _x = i % grid_width
			var _y = i / grid_width
			var _pos = Vector2i(_x, _y)
			_grid_positions.append(_pos)

			var _debug_string = "New slot created! Position: ({0}, {1})"
			print_debug(_debug_string.format([_x, _y]))
	else:
		#TODO: remove _grid_positions from array based on what items are in the inventory
		pass


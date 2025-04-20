extends Resource
class_name InventoryData

@export var max_items: int = 6
var _item_array: Array[ItemData] = []
var grid_width: int = 4
var grid_height: int = 2

func _init() -> void:
	_item_array.resize(max_items)
	_item_array.fill(null)

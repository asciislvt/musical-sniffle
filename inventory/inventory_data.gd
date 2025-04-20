extends Resource
class_name InventoryData

@export var max_slots: int = 8
@export var grid_width: int = 4
var _item_array: Array[ItemData] = []

func get_grid_width() -> int:
	return grid_width

func _init() -> void:
	pass


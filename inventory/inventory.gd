extends Node
class_name InventoryManager

@export var data: InventoryData

func _ready() -> void:
	if !data:
		print_debug("no inventory data!")
	data._init()


func add_item(_item: ItemData) -> void:
	pass

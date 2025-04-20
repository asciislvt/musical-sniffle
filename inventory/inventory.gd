extends Node
class_name InventoryManager

@export var data: InventoryData

func _ready() -> void:
	if !data:
		print_debug("no inventory data!")
	Global.inv_player_data_requested.connect(self._on_data_requested)

func _on_data_requested(_requester: InventoryGrid) -> void:
	_requester.set_data(data)

func add_item(_item: ItemData) -> void:
	pass

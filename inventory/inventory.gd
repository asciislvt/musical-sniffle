extends Node
class_name InventoryManager

@export var data: InventoryData

func _ready() -> void:
	if !data:
		print_debug("no inventory data!")
	data.init_inv()
	Global.inv_player_data_requested.connect(self._on_data_requested)
	Global.item_picked.connect(self._on_item_picked)
	Global.inv_item_move_requested.connect(self._on_item_move_requested)

func _on_item_move_requested(_id: int, _anchor: Vector2i) -> void:
	data.try_move_item(_id, _anchor)

func _on_data_requested(_requester: InventoryGrid) -> void:
	_requester.set_data(data)

func _on_item_picked(_item: ItemData) -> void:
	data.try_add_item(_item)
	Global.inv_updated.emit(data)


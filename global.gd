extends Node

signal inv_player_data_requested(_node: InventoryGrid)
signal item_picked(_item: ItemData)

@export var _item_pool: Array[ItemData]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("add_item"):
			item_picked.emit(_random_item())

func _random_item() -> ItemData:
	var i: int = randi_range(0, _item_pool.size() - 1)
	return _item_pool[i]

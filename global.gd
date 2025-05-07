extends Node

signal item_picked(_item: ItemData)
signal inv_player_data_requested(_node: InventoryGrid)
signal inv_item_move_requested(_id: int, _new_anchor: Vector2i)
signal inv_item_moved(_anchor: Vector2i)
signal inv_updated(_data: InventoryData)

@export var item_pool: Array[ItemData]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("add_item"):
			item_picked.emit(_random_item())

func _random_item() -> ItemData:
	var i: int = randi_range(0, item_pool.size() - 1)
	return item_pool[i]

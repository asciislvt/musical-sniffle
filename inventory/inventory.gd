extends Node
class_name InventoryManager

@export var data: InventoryData
@export var _object_pool: Array[ItemData]


func _ready() -> void:
	if !data:
		print_debug("no inventory data!")
	data.init_inv()
	Global.inv_player_data_requested.connect(self._on_data_requested)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("add_item"):
			pass

func _on_data_requested(_requester: InventoryGrid) -> void:
	_requester.set_data(data)

func add_item(_item: ItemData) -> void:
	pass

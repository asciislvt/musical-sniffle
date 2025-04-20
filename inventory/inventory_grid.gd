extends PanelContainer
class_name InventoryGrid

@export var slot_scene: PackedScene

var _grid_container: GridContainer = null
var _slot_array: Array[Control] = []
var _columns: int

func _ready() -> void:
	print_debug("inventory grid getting ready")
	for child in get_children():
		if child is GridContainer:
			_grid_container = child
	Global.inv_player_data_requested.emit(self)

func set_data(_data: InventoryData) -> void:
	_build_inventory(_data)

func _build_inventory(_data: InventoryData) -> void:
	_columns = _data.get_grid_width()
	_grid_container.columns = _columns

	for i in _data.max_slots:
		var _slot: InventorySlot = slot_scene.instantiate()

		var _x = i % _columns
		var _y = i / _columns

		_slot.set_grid_position(Vector2i(_x, _y))
		_grid_container.add_child(_slot)
		_slot_array.append(_slot)

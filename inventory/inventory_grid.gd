extends PanelContainer
class_name InventoryGrid

@export var slot_scene: PackedScene
@export var _grid_container: GridContainer = null

var _slot_array: Array[Control] = []
var _columns: int
var _item_held: Control

func _ready() -> void:
	if !_grid_container:
		print_debug("no grid container :((")
	Global.inv_player_data_requested.emit(self)

func set_data(_data: InventoryData) -> void:
	_build_inventory(_data)

func _build_inventory(_data: InventoryData) -> void:
	_clear_grid()
	_columns = _data.get_grid_width()
	_grid_container.columns = _columns

	for i in _data.max_slots:
		var _slot: InventorySlot = slot_scene.instantiate()

		var _x = i % _columns
		var _y = i / _columns

		_slot.set_grid_position(Vector2i(_x, _y))
		_grid_container.add_child(_slot)
		_slot_array.append(_slot)

		# var _debug_string = "New slot created! Position: ({0}, {1})"
		# print_debug(_debug_string.format([_x, _y]))

func _clear_grid() -> void:
	for _child in _grid_container.get_children():
		_child.queue_free()
	
	_slot_array.clear()

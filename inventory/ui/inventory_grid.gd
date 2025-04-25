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
		var _x = i % _columns
		var _y = i / _columns
		var _pos = Vector2i(_x, _y)

		_add_slot(_grid_container, _pos)


func _add_slot(_parent: Node, _pos: Vector2i) -> void:
	var _slot: InventorySlot = slot_scene.instantiate()

	_slot.set_grid_position(_pos)
	_slot_array.append(_slot)
	_parent.add_child(_slot)

func _clear_grid() -> void:
	for _child in _grid_container.get_children():
		_child.queue_free()
	
	_slot_array.clear()

extends PanelContainer
class_name InventoryGrid

@export var slot_scene: PackedScene
@export var item_scene: PackedScene
@export var _grid_container: GridContainer = null

var _slots: Dictionary[Vector2i, GridSlot] = {}
var _columns: int
var _item_held: Control

func _ready() -> void:
	if !_grid_container:
		print_debug("no grid container :((")

	Global.inv_player_data_requested.emit(self)
	Global.inv_updated.connect(self._on_inv_updated)

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
	
	var _items: Array[GridItemData] = _data.get_items()
	if !_items.is_empty():
		for _item in _items:
			var _parent = _item.anchor_pos
			_add_item(_slots[_parent], _item)
	else:
		return

func _clear_grid() -> void:
	for _child in _grid_container.get_children():
		_child.queue_free()

	_slots.clear()

func _add_item(_parent: Node, _data: GridItemData):
	var _item: GridItem = item_scene.instantiate()
	_item.load_item(_data)
	_parent.add_child(_item)

func _add_slot(_parent: Node, _pos: Vector2i) -> void:
	var _slot: GridSlot = slot_scene.instantiate()

	_slot.set_grid_position(_pos)
	_slots[_pos] = _slot
	_parent.add_child(_slot)

func _on_inv_updated(_data: InventoryData) -> void:
	print_debug("inventory updated, rebuilding!")
	_build_inventory(_data)

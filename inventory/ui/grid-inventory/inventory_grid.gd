extends PanelContainer
class_name InventoryGrid

signal item_picked()
signal item_placed()

@export var slot_scene: PackedScene
@export var item_scene: PackedScene
@export var slot_container: GridContainer = null
@export var item_container: Control = null

var _slots: Dictionary[Vector2i, GridSlot] = {}
var _columns: int
var _slot_hovered: GridSlot
var _item_held: GridItem

func _ready() -> void:
	if !slot_container:
		print_debug("no grid container :((")
	if !item_container:
		print_debug("no item contaienr :((")
	Global.inv_player_data_requested.emit(self)
	Global.inv_updated.connect(self._on_inv_updated)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("fire1"):
			if !_item_held:
				_pick_item()
			else:
				_place_item()

func set_data(_data: InventoryData) -> void:
	_build_inventory(_data)

func _build_inventory(_data: InventoryData) -> void:
	if _data.max_slots != _slots.size():
		print_debug("rebuilding grid")
		_clear_slots()
		_columns = _data.get_grid_width()
		slot_container.columns = _columns
	
		for i in _data.max_slots:
			var _x = i % _columns
			var _y = i / _columns
			var _pos = Vector2i(_x, _y)

			_add_slot(slot_container, _pos)
	
	print_debug("rebuilding items")
	_clear_items()
	var _items: Array[GridItemData] = _data.get_items()
	if !_items.is_empty():
		for _item in _items:
			var _parent = _item.anchor_pos
			_add_item(_slots[_parent], _item)
	else:
		return

func _pick_item() -> void:
	for child in item_container.get_children():
		if child is GridItem:
			if child.is_hovered():
				child.hold_item()
				_item_held = child
				item_picked.emit()

func _place_item() -> void:
	var _anchor_slot: GridSlot
	if _slot_hovered:
		_anchor_slot = _slot_hovered
	else:
		_anchor_slot = _slots[_item_held._anchor]
		_item_held.place_item(_anchor_slot)
		_item_held = null
		item_placed.emit()
	
	Global.inv_item_moved.emit(_item_held._id, _anchor_slot._grid_position)

func _clear_slots() -> void:
	for _child in slot_container.get_children():
		_child.queue_free()
	_slots.clear()

func _clear_items() -> void:
	for _child in item_container.get_children():
		_child.queue_free()

func _add_item(_parent: Control, _data: GridItemData):
	var _item: GridItem = item_scene.instantiate()

	item_placed.connect(_item._on_item_placed)
	item_picked.connect(_item._on_item_held)

	_item.set_position(_parent.position)
	_item.load_item(_data)
	item_container.add_child(_item)

func _add_slot(_parent: Node, _pos: Vector2i) -> void:
	var _slot: GridSlot = slot_scene.instantiate()

	_slot.slot_hovered.connect(self._on_slot_hovered)
	_slot.slot_left.connect(self._on_slot_left)

	_slot.set_grid_position(_pos)
	_slots[_pos] = _slot
	_parent.add_child(_slot)

func _on_slot_hovered(slot: GridSlot) -> void:
	_slot_hovered = slot

func _on_slot_left() -> void:
	_slot_hovered = null

func _on_inv_updated(_data: InventoryData) -> void:
	print_debug("inventory updated, rebuilding!")
	_build_inventory(_data)

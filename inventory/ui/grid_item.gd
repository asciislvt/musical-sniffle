extends Control
class_name GridItem

enum ItemStates{
	ITEM_DEFAULT,
	ITEM_HOVER,
	ITEM_HELD,
}

@export var icon: TextureRect
var _state: ItemStates = ItemStates.ITEM_DEFAULT
var _anchor: Vector2i
var _pos_taken: Array[Vector2i]

func _process(_delta: float) -> void:
	match _state:
		ItemStates.ITEM_DEFAULT:
			pass
		ItemStates.ITEM_HOVER:
			pass
		ItemStates.ITEM_HELD:
			pass

func load_item(_data: GridItemData) -> void:
	icon.texture = _data.icon
	_anchor = _data.anchor_pos
	_pos_taken = _data.pos_taken

func hold_item() -> void:
	_state = ItemStates.ITEM_HELD

func place_item() -> void:
	_state = ItemStates.ITEM_DEFAULT

func _on_texture_rect_mouse_exited() -> void:
	_state = ItemStates.ITEM_DEFAULT
	print_debug("mouse exited, returning to default state")

func _on_texture_rect_mouse_entered() -> void:
	_state = ItemStates.ITEM_HOVER
	print_debug("mouse entered, changing to hover state")


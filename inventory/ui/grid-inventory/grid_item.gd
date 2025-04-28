extends GridNode
class_name GridItem

@export var icon: TextureRect
var _anchor: Vector2i
var _pos_taken: Array[Vector2i]

func _ready() -> void:
	_set_state(ItemStates.ITEM_DEFAULT)
	icon.mouse_entered.connect(self._on_mouse_entered)
	icon.mouse_exited.connect(self._on_mouse_exited)

func load_item(_data: GridItemData) -> void:
	icon.texture = _data.icon
	_anchor = _data.anchor_pos
	_pos_taken = _data.pos_taken

func hold_item() -> void:
	_set_state(ItemStates.ITEM_HELD)

func place_item() -> void:
	_set_state(ItemStates.ITEM_DEFAULT)

extends Control
class_name GridItem

@export var icon: TextureRect
var _anchor: Vector2i
var _pos_taken: Array[Vector2i]

func load_item(_data: GridItemData) -> void:
	icon.texture = _data.icon
	_anchor = _data.anchor_pos
	_pos_taken = _data.pos_taken

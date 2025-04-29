extends Resource
class_name GridItemData

var anchor_pos: Vector2i
var pos_taken: Array[Vector2i]
var offsets: Array[Vector2i]
var icon: Texture2D

func _init(_pos_taken: Array[Vector2i], _data: ItemData) -> void:
	pos_taken = _pos_taken
	anchor_pos = pos_taken[0]
	offsets = _data.shape_offset
	icon = _data.icon

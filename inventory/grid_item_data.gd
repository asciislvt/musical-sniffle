extends Resource
class_name GridItemData

var id: int
var anchor_pos: Vector2i
var pos_taken: Array[Vector2i]
var offsets: Array[Vector2i]
var icon: Texture2D

func _init(_pos_taken: Array[Vector2i], _data: ItemData) -> void:
	pos_taken = _pos_taken
	anchor_pos = pos_taken[0]
	offsets = _data.shape_offset
	icon = _data.icon

func set_id(_id: int) -> void:
	id = _id

func set_position(_anchor: Vector2i) -> void:
	anchor_pos = _anchor
	pos_taken.clear()
	for offset in offsets:
		pos_taken.append(anchor_pos + offset)

func get_positions_taken() -> Array[Vector2i]:
	if pos_taken.is_empty():
		return []

	return pos_taken

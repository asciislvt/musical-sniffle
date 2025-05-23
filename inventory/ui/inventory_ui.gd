extends Control
class_name InventoryUI

@export var grid_inventory_scene: PackedScene
@export var hbox: HBoxContainer

var grid_inv_array: Array[Control]

func _ready() -> void:
	visible = false
	if grid_inv_array.is_empty():
		var _scene = grid_inventory_scene.instantiate()
		hbox.add_child(_scene)
		grid_inv_array.append(_scene)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("tab"):
			_toggle_ui()

func _toggle_ui() -> void:
	match visible:
		true:
			visible = false
		false:
			visible = true

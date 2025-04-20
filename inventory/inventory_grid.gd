extends PanelContainer
class_name InventoryGrid


func set_data(_data: InventoryData) -> void:
	_build_inventory(_data)

func _build_inventory(_data: InventoryData) -> void:
	print_debug("bulding inventory :33")

extends PanelContainer
class_name InventoryItemSlotUI

signal item_dropped(index: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	theme_type_variation = 'ItemPanel'


func on_mouse_entered() -> void:
	theme_type_variation = "HoveredItemPanel"
	
	
func on_mouse_exited() -> void:
	theme_type_variation = 'ItemPanel'


func _can_drop_data(_position, data):
	return data is InventoryItem


func _drop_data(_position, _data):
	item_dropped.emit(get_index())

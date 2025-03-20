extends Node


@onready var grid: GridContainer = %GridContainer

var slot_scene = preload("res://scenes/items/inventory_item_slot.tscn")
var item_scene = preload("res://scenes/items/inventory_item.tscn")

var player_inventory: Inventory = preload("res://resources/inventories/player_inventory.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func fill_grid():
	for child in grid.get_children():
		child.queue_free()
	for i  in range(player_inventory.max_size):
		var slot: InventoryItemSlotUI = slot_scene.instantiate()
		slot.item_dropped.connect(_on_inventory_slot_item_dropped)
		grid.add_child(slot)
		if player_inventory.items[i]:
			var item: InventoryItemUI = item_scene.instantiate()
			item.drag_started.connect(_on_inventory_item_drag_started)
			slot.add_child(item)
			item.load_item(player_inventory.items[i])


func _on_inventory_slot_item_dropped(index: int):
	player_inventory.drop_item(index)
	fill_grid()


func _on_inventory_item_drag_started(item: InventoryItem):
	player_inventory.drag_item(item)


func _can_drop_data(_position, data):
	print(data)
	return data is InventoryItem

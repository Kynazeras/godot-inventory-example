extends MarginContainer
class_name InventoryItemUI

const TEXTURE_RECT_DIMENSIONS = Vector2(32,32)

@onready var item_texture: TextureRect = %ItemTexture
@onready var item_quantity: Label = %Quantity
@onready var item_state_machine: ItemStateMachine = %ItemStateMachine

signal drag_started(item: InventoryItem)

var current_item: InventoryItem = null

var dummy_item: InventoryItem = preload("res://resources/placeholders/dummy_item.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	item_state_machine.init(self)
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)
	gui_input.connect(_gui_input)
	load_item(dummy_item)


func load_item(item: InventoryItem):
	current_item = item
	item_texture.texture = item.item.sprite
	if item.item.stackable:
		item_quantity.text = str(item.quantity)
	else:
		item_quantity.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _mouse_entered():
	item_state_machine.on_mouse_entered()


func _mouse_exited():
	item_state_machine.on_mouse_exited()


func _gui_input(event):
	item_state_machine.on_gui_input(event)


func make_drag_preview():
	var rect = TextureRect.new()
	rect.texture = current_item.item.sprite
	rect.custom_minimum_size = TEXTURE_RECT_DIMENSIONS
	return rect


func _get_drag_data(_at_position):
	set_drag_preview(make_drag_preview())
	return current_item

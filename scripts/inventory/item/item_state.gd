class_name ItemState
extends Node

enum State {BASE, CLICKED, DRAGGING, RELEASED}

signal transition_requested(from: ItemState, to: State)

@export var state: State
# add type
var item_ui: InventoryItemUI

func enter() -> void:
	pass
	

func post_enter() -> void:
	pass


func exit() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass
	

func on_gui_input(_event: InputEvent) -> void:
	pass
	

func on_mouse_entered() -> void:
	pass
	
	
func on_mouse_exited() -> void:
	pass
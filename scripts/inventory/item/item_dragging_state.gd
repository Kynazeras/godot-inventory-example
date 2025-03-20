extends ItemState


func enter():
	if not item_ui.is_node_ready():
		await item_ui.ready

	item_ui.drag_started.emit(item_ui.current_item)


func on_gui_input(event: InputEvent):
	# var mouse_motion = event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_click")
	# var released = event.is_action_released("left_click")

	if cancel:
		transition_requested.emit(self, ItemState.State.BASE)

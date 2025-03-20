extends ItemState


func enter() -> void:
	if not item_ui.is_node_ready():
		await item_ui.ready


func exit() -> void:
	pass


func on_input(event: InputEvent):
	if event.is_action_released('left_click'):
		transition_requested.emit(self, ItemState.State.BASE)


func on_gui_input(event: InputEvent):
		if event is InputEventMouseMotion:
			transition_requested.emit(self, ItemState.State.DRAGGING)
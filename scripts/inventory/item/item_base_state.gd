extends ItemState

func enter() -> void:
	if not item_ui.is_node_ready():
		await item_ui.ready


func exit() -> void:
	pass


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		transition_requested.emit(self, ItemState.State.CLICKED)


func on_mouse_entered() -> void:
	item_ui.theme_type_variation = "HoveredItemPanel"
	
	
func on_mouse_exited() -> void:
	item_ui.theme_type_variation = ''
